:: SPECpower_ssj runssj.bat
::
:: This is an example of what a run script might look like
::
@echo off

:: Set the number of JVMs to run
set JVMS=76

:: Set to TRUE if jvm Director is on this host
set LOCAL_DIRECTOR=FALSE
set DIRECTOR_HOST=192.168.0.100
::set LOCAL_DIRECTOR=TRUE
::set DIRECTOR_HOST=localhost

:: The SETID is used to identify the descriptive configuration properties
:: that will be used for the system under test.  For example, with a SETID
:: of "sut", the descriptive configuration properties will be read from the
:: file SPECpower_ssj_config_sut.props from the Director system.
set SETID=sut

:: Properties file to be passed to Director
::#@set DIRECTOR_PROPFILE=SPECpower_ssj_EXPERT.props
set DIRECTOR_PROPFILE=SPECpower_ssj_EXPERT-single-EMR.props
::set DIRECTOR_PROPFILE=SPECpower_ssj_EXPERT-short.props

:: Benchmark run rules require a list of active OS services be retained for publishable runs.
:: For Windows, this can be accomplished by uncommenting the following line.
:: net start > services.txt

:: Set java options for ssj and director
::#@ibm java
::set JAVAOPTIONS_SSJ=-Xmn700m -Xms937m -Xmx937m -Xaggressive -Xcompressedrefs -Xgcpolicy:gencon -XlockReservation -Xnoloa -XtlhPrefetch -Xlp -Xconcurrentlevel0 -Xthr:minimizeusercpu -Xgc:preferredHeapBase=0x80000000  -Xgcthreads8
::set JAVAOPTIONS_SSJ=-Xmn700m -Xms937m -Xmx937m -Xaggressive -Xcompressedrefs -Xgcpolicy:gencon -XlockReservation -Xnoloa -XtlhPrefetch -Xlp -Xconcurrentlevel0 -Xthr:minimizeusercpu -Xgc:preferredHeapBase=0x80000000 -Xgcthreads4

::11.0.8,UseCompressedStrings will be disabled automatically with JDK11 and above
::set JAVAOPTIONS_SSJ=-server -Xmn1300m -Xms1550m -Xmx1550m -XX:SurvivorRatio=1 -XX:TargetSurvivorRatio=99 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+UseLargePages -XX:+UseParallelOldGC -XX:UseAVX=1 -XX:BiasedLockingStartupDelay=30000 -XX:-UseAdaptiveSizePolicy -XX:-ThreadLocalHandshakes

::JDK17
set JAVAOPTIONS_SSJ=-server -Xmn1300m -Xms1550m -Xmx1550m -XX:SurvivorRatio=1 -XX:TargetSurvivorRatio=99 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+UseLargePages -XX:+UseParallelGC -XX:UseAVX=0 -XX:BiasedLockingStartupDelay=30000 -XX:-UseAdaptiveSizePolicy -XX:+UseBiasedLocking -XX:+UseOptoBiasInlining -XX:+UseFastStosb -XX:MaxInlineLevel=9 -XX:MaxVectorSize=32 -XX:-UseSharedSpaces -XX:-UseXMMForObjInit -XX:-UseBASE64Intrinsics -XX:+OptimizeFill -XX:+CriticalJNINatives

::oracle java
::set JAVAOPTIONS_SSJ=-server -Xmn700m -Xms937m -Xmx937m -XX:SurvivorRatio=60 -XX:TargetSurvivorRatio=90 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+AggressiveOpts -XX:+UseLargePages -XX:+UseParallelOldGC  -XX:-UseAdaptiveSizePolicy
::set JAVAOPTIONS_SSJ=-server -Xmn700m -Xms937m -Xmx937m -XX:SurvivorRatio=60 -XX:TargetSurvivorRatio=90 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+AggressiveOpts -XX:+UseLargePages -XX:+UseParallelOldGC -XX:+UseCompressedStrings -XX:-UseAdaptiveSizePolicy
::#@oracle java
::set JAVAOPTIONS_SSJ=-server -Xmn1300m -Xms1550m -Xmx1550m -XX:SurvivorRatio=1 -XX:TargetSurvivorRatio=99 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+AggressiveOpts -XX:+UseLargePages -XX:+UseParallelOldGC
::copy from sp site
::set JAVAOPTIONS_SSJ= -Xmx1550m -Xms1550m -Xmn1300m -XX:SurvivorRatio=1 -XX:TargetSurvivorRatio=99 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+UseLargePages -XX:+UseParallelOldGC -XX:+AggressiveOpts

::set JAVAOPTIONS_SSJ= -server -Xmn700m -Xms937m -Xmx937m -XX:SurvivorRatio=60 -XX:TargetSurvivorRatio=90 -XX:ParallelGCThreads=2 -XX:AllocatePrefetchDistance=256 -XX:AllocatePrefetchLines=4 -XX:LoopUnrollLimit=45 -XX:InitialTenuringThreshold=12 -XX:MaxTenuringThreshold=15 -XX:InlineSmallCode=3900 -XX:MaxInlineSize=270 -XX:FreqInlineSize=2500 -XX:+AggressiveOpts -XX:+UseLargePages -XX:+UseParallelOldGC -XX:+UseCompressedStrings -XX:-UseAdaptiveSizePolicy

:: Set JAVA to Java.exe path
::#@this is for ibm java
::set JAVA=c:\zzz\ibm_sdk70\bin\java

::#@oracle java
::set JAVA=java
::set JAVA="c:\Program Files\Java\jre7\bin\java.exe"
::set JAVA="c:\Program Files\Java\jdk-11.0.8\bin\java.exe"
set JAVA="C:\SPECpower_ssj2008-v1.12\java\jdk-17+35\bin\java.exe"

:: if JAVA not set, let's find it.
if $%JAVA%$ == $$ goto findjava

goto foundjava

:findjava
:: Note, this algorithm finds the last occurance of java.exe in path.
echo Attempting to find java...
:: for %%p in ( %PATH% ) do if exist %%p\java.exe set JAVA=%%p\java
:: if $%JAVA%$ == $$ goto nojava
:: echo Found java: %JAVA%

:foundjava
@echo on
%JAVA% -version
@echo off
goto stage1

:nojava
echo No java?  Please make sure that the path to java is set in your environment!
echo Current PATH: %PATH%
goto egress

:stage1
set SSJJARS=.\ssj.jar;.\check.jar;.\lib\jcommon-1.0.16.jar;.\lib\jfreechart-1.0.13.jar
if "%CLASSPATHPREV%" == $$ set CLASSPATHPREV=%CLASSPATH%
set CLASSPATH=
goto stage2

:stage2
set CLASSPATH=%SSJJARS%;%CLASSPATHPREV%
echo Using CLASSPATH entries:
for %%c in ( %CLASSPATH% ) do echo %%c

:stage3
set I=0
IF %JVMS% == 0 GOTO END
:LOOP
set /a I=%I + 1
@echo on
@echo.
@echo Starting instance %I%
::start "SPECpower_ssj, jvm %I% of %JVMS%" %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
:: 1JVM/2 Logical Cores
If %I%==1  start /node 0 /affinity 3 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==2  start /node 0 /affinity c cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==3  start /node 0 /affinity 30 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==4  start /node 0 /affinity c0 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==5  start /node 0 /affinity 300 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==6  start /node 0 /affinity c00 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==7  start /node 0 /affinity 3000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==8  start /node 0 /affinity c000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==9  start /node 0 /affinity 30000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==10 start /node 0 /affinity c0000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==11 start /node 0 /affinity 300000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==12 start /node 0 /affinity c00000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==13 start /node 0 /affinity 3000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==14 start /node 0 /affinity c000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==15 start /node 0 /affinity 30000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==16 start /node 0 /affinity c0000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==17 start /node 0 /affinity 300000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==18 start /node 0 /affinity c00000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==19 start /node 0 /affinity 3000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==20 start /node 0 /affinity c000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==21 start /node 0 /affinity 30000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==22 start /node 0 /affinity c0000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==23 start /node 0 /affinity 300000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==24 start /node 0 /affinity c00000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==25 start /node 0 /affinity 3000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==26 start /node 0 /affinity c000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==27 start /node 0 /affinity 30000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==28 start /node 0 /affinity c0000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==29 start /node 0 /affinity 300000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==30 start /node 0 /affinity c00000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==31 start /node 0 /affinity 3000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==32 start /node 0 /affinity c000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==33 start /node 0 /affinity 30000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==34 start /node 0 /affinity c0000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==35 start /node 0 /affinity 300000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==36 start /node 0 /affinity c00000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==37 start /node 0 /affinity 3000000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==38 start /node 0 /affinity c000000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%



If %I%==39  start /node 1 /affinity 3 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==40  start /node 1 /affinity c cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==41  start /node 1 /affinity 30 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==42  start /node 1 /affinity c0 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==43  start /node 1 /affinity 300 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==44  start /node 1 /affinity c00 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==45  start /node 1 /affinity 3000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==46  start /node 1 /affinity c000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==47  start /node 1 /affinity 30000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==48 start /node 1 /affinity c0000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==49 start /node 1 /affinity 300000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==50 start /node 1 /affinity c00000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==51 start /node 1 /affinity 3000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==52 start /node 1 /affinity c000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==53 start /node 1 /affinity 30000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==54 start /node 1 /affinity c0000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==55 start /node 1 /affinity 300000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==56 start /node 1 /affinity c00000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==57 start /node 1 /affinity 3000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==58 start /node 1 /affinity c000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==59 start /node 1 /affinity 30000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==60 start /node 1 /affinity c0000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==61 start /node 1 /affinity 300000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==62 start /node 1 /affinity c00000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==63 start /node 1 /affinity 3000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==64 start /node 1 /affinity c000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==65 start /node 1 /affinity 30000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==66 start /node 1 /affinity c0000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==67 start /node 1 /affinity 300000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==68 start /node 1 /affinity c00000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==69 start /node 1 /affinity 3000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==70 start /node 1 /affinity c000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==71 start /node 1 /affinity 30000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==72 start /node 1 /affinity c0000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==73 start /node 1 /affinity 300000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==74 start /node 1 /affinity c00000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==75 start /node 1 /affinity 3000000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%
If %I%==76 start /node 1 /affinity c000000000000000000 cmd /k %JAVA% %JAVAOPTIONS_SSJ% org.spec.power.ssj.SpecPowerSsj -jvmId %I% -numJvms %JVMS% -director %DIRECTOR_HOST% -setid %SETID%


    
	
@echo off
IF %I% == %JVMS% GOTO END
GOTO LOOP
:END

IF NOT %LOCAL_DIRECTOR% == TRUE GOTO egress
@echo on
@echo.
@echo Starting Director
::%JAVA% %JAVAOPTIONS_DIRECTOR% org.spec.power.ssj.Director -propfile %DIRECTOR_PROPFILE%
@echo off

goto egress

:egress
::#@
::exit
