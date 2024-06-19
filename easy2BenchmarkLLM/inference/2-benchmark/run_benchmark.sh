#!/bin/bash
MODEL_SIZES=(7 13 34)
BATCH_SIZES=(1 8 16 32)
RANK=4
INSTANCES=(1 2 4)
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for INSTANCE in ${INSTANCES[*]}; do
    for MODEL_SIZE in ${MODEL_SIZES[*]}; do
        for BATCH_SIZE in ${BATCH_SIZES[*]}; do
            for INPUT_LEN in ${INPUT_LENS[*]}; do
                for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
                    ./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
                done
            done
        done
    done
done

MODEL_SIZES=(7 13)
BATCH_SIZES=(1 8 16 32)
RANK=4
INSTANCES=8
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for MODEL_SIZE in ${MODEL_SIZES[*]}; do
	for BATCH_SIZE in ${BATCH_SIZES[*]}; do
		for INPUT_LEN in ${INPUT_LENS[*]}; do
			for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
				./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
			done
		done
	done
done


MODEL_SIZE=70
BATCH_SIZES=(1 2 4 8)
RANK=4
INSTANCE=1
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for BATCH_SIZE in ${BATCH_SIZES[*]}; do
	for INPUT_LEN in ${INPUT_LENS[*]}; do
		for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
			./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
		done
	done
done


MODEL_SIZE=34
BATCH_SIZE=4
RANK=4
INSTANCES=(1 2 4)
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for INSTANCE in ${INSTANCES[*]}; do
	for INPUT_LEN in ${INPUT_LENS[*]}; do
		for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
			./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
		done
	done
done

MODEL_SIZE=7
BATCH_SIZE=64
RANK=4
INSTANCES=(1 2 4)
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for INSTANCE in ${INSTANCES[*]}; do
	for INPUT_LEN in ${INPUT_LENS[*]}; do
		for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
			./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
		done
	done
done


MODEL_SIZES=(7 13 34)
BATCH_SIZES=(1 8 16)
RANK=1
INSTANCES=(1 2)
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for MODEL_SIZE in ${MODEL_SIZES[*]}; do
    for INSTANCE in ${INSTANCES[*]}; do
        for BATCH_SIZE in ${BATCH_SIZES[*]}; do
            for INPUT_LEN in ${INPUT_LENS[*]}; do
                for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
                    ./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
                done
            done
        done
    done
done



MODEL_SIZE=70
BATCH_SIZES=(1 8)
RANK=1
INSTANCE=1
INPUT_LENS=(256 512 1024)
OUTPUT_LENS=(512 1024)
for BATCH_SIZE in ${BATCH_SIZES[*]}; do
	for INPUT_LEN in ${INPUT_LENS[*]}; do
		for OUTPUT_LEN in ${OUTPUT_LENS[*]}; do
			./inference.sh $MODEL_SIZE $RANK $BATCH_SIZE $INSTANCE $INPUT_LEN $OUTPUT_LEN
		done
	done
done

