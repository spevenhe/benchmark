import re
import os
import csv
import argparse


def add_argument():
    parser = argparse.ArgumentParser(description="Your script's description here")
    parser.add_argument("--logdir", type=str, help="log dir", default="logs")
    args = parser.parse_args()
    return args

def map_model_name(model_size):
    if model_size == 7:
        return 'Llama2-7B'
    if model_size == 13:
        return 'Llama2-13B'
    if model_size == 34:
        return 'CodeLlama-34B'
    if model_size == 70:
        return 'Llama2-70B'
    return None

if __name__ == "__main__":
    args = add_argument()
    result = []
    dir_name = args.logdir

    for filename in os.listdir(dir_name):
        if filename.endswith('.log'):
            with open(os.path.join(dir_name, filename), 'r') as file:
                content = file.read()
                try:
                    summaries = re.findall(r'-{10} Summary: -{10}(.*?)(?=-{10} Summary: -{10}|$)', content, re.DOTALL)
                except AttributeError:
                    print(f"Failed to process {filename}")
                    continue

                cold_start, warm_start = [], []
                latency, first_token, average, p90, p99 = [], [], [], [], []

                for summary in summaries:
                    try:
                        latency.append(float(re.search('Inference latency: (.*?) sec', summary, re.DOTALL).group(1)))
                        first_token.append(float(re.search('First token average latency: (.*?) sec', summary, re.DOTALL).group(1)))
                        average.append(float(re.search('Average 2... latency: (.*?) sec', summary, re.DOTALL).group(1)))
                        p90.append(float(re.search('P90 2... latency: (.*?) sec', summary, re.DOTALL).group(1)))
                        p99.append(float(re.search('P99 2... latency: (.*?) sec', summary, re.DOTALL).group(1)))
                        warm_start.append(float(re.search('warm loading: (.*?) sec', summary, re.DOTALL).group(1)))
                    except:
                        pass
                    try:
                        cold_start.append(float(re.search('cold loading: (.*?) sec', summary, re.DOTALL).group(1)))
                    except:
                        pass

                try:
                    latency = max(latency)
                    first_token = max(first_token) 
                    average = max(average) 
                    p90 = max(p90) 
                    p99 = max(p99)
                    warm_start = round(sum(warm_start)/len(warm_start), 3) if cold_start else None
                    cold_start = round(sum(cold_start)/len(cold_start), 3) if cold_start else None
                    inference_latency = round(latency - first_token,3) 
                except:
                    print(f"Failed to process {filename}")
                    continue
                try:
                    filename_no_ext = os.path.splitext(filename)[0]  #用来去掉扩展名
                    matches = re.match(r'(\d+)b_(\d+)rank_bs(\d+)_beam(\d+)_(\d+)i_(\d+)input_(\d+)output', filename_no_ext)

                    model_size, rank, batch_size, beam_size, instances, input_tokens, output_tokens = [int(i) for i in matches.groups('1')]
                except AttributeError:
                    print(f"Failed to process {filename}")
                    continue
                result.append({
                    'model': map_model_name(model_size),
                    'model_size': model_size,
                    'rank': rank,
                    'num_instances': instances,
                    'batch_size': batch_size,
                    'beam_size': beam_size,    # 如果未指定 beam_size，则默认为 1
                    'precision': 'BF16', 
                    'input tokens': input_tokens,
                    'output tokens': output_tokens,
                    'Total latency [sec]': latency,
                    'Inference latency [sec]': inference_latency,
                    'First token average latency [sec]': first_token,
                    'Average 2nd+ latency [sec]': average,
                    'P90 2nd+ latency [sec]': p90,
                    'P99 2nd+ latency [sec]': p99,
                    'Throughpout [token/s] = (output-token/inference latency)*batch size* num instances': round(output_tokens/inference_latency*instances*batch_size, 3),
                    'Average throughpout [token/s] = (output-token/total latency)*batch size* num instances': round(output_tokens/latency*instances*batch_size, 3),
                    'Cold initialization [sec]': cold_start,
                    'Warm initialization [sec]': warm_start
                })

    result = sorted(result, key=lambda row: (row['model_size'], row['rank'], row['num_instances'], row['beam_size'], row['batch_size'], row['input tokens'], row['output tokens']))
    headers = ['model', 'model_size', 'rank', 'num_instances', 'batch_size', 'beam_size', 'precision', 'input tokens', 'output tokens', 'Total latency [sec]', 'Inference latency [sec]',\
            'First token average latency [sec]', 'Average 2nd+ latency [sec]', 'P90 2nd+ latency [sec]', 'P99 2nd+ latency [sec]', \
            'Throughpout [token/s] = (output-token/inference latency)*batch size* num instances', \
            'Average throughpout [token/s] = (output-token/total latency)*batch size* num instances', \
            'Cold initialization [sec]', 'Warm initialization [sec]']
        
    save_path = os.path.join(args.logdir, "output.csv")
    with open(save_path, 'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=headers)
        writer.writeheader()
        writer.writerows(result)