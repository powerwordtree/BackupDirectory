::ͨ���ӳ���
::@author FB
::@version 0.1

@ECHO OFF
CALL :%*
GOTO :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::ȥ��β�ո�
::  ����1: Ŀ���ַ���
::  ����$: ��������ַ���
:TRIM
CALL :TRIM_CALL %~1
GOTO :EOF
:TRIM_CALL
SET "$=%*"
GOTO :EOF

::��ȡ�ַ�������
::  ����1: �ַ���
::  ����$: ����
:GET_SIZE
SET "$STR=%~1#"
SET "$=0"
FOR %%I IN (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) DO (
  IF NOT "!$STR:~%%I,1!" == "" (
    SET /A "$+=%%I"
    SET "$STR=!$STR:~%%I!"
  )
)
SET "$STR="
GOTO :EOF

::�ж��ַ����Ƿ���ָ���ַ�����β
::  ����1: Ŀ���ַ���
::  ����2: ָ���ַ���
::  ����$: TRUE/FALSE
:END_WITH
SET "$STR=%~1"
CALL :GET_SIZE "%~2"
IF /I "!$STR:~-%$%!" == "%~2" (
  SET "$=TRUE"
) ELSE (
  SET "$=FALSE"
)
SET "$STR="
GOTO :EOF

::�ӳ�
::  ����1: ʱ��(��)
:SLEEP
SET /A "$=%~1 + 0"
CHOICE /T "%$%" /D "Y" 1>NUL 2>NUL 
GOTO :EOF