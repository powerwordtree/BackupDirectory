::�����ӳ���
::@author FB
::@version 0.1

@ECHO OFF
CALL :%*
GOTO :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::���鴴��
::  ����1: ������
:NEW
SET "%~1=0"
GOTO :EOF

::��������
::  ����1: ������
:DESTROY
CALL :EACH "%~1" "SET %~1[{K}]="
SET "%~1="
GOTO :EOF

::�������
::  ����1: ������
:CLEAR
CALL :DESTROY "%~1"
CALL :NEW "%~1"
GOTO :EOF

::����ѹ��
::  ����1: ������
::  ����2: Ԫ��
:PUSH
CALL SET "%~1[%%%~1%%]=%~2"
SET /A "%~1+=1"
GOTO :EOF

::���鵯��
::  ����1: ������
::  ����$: Ԫ��
:POP
SET /A "%~1-=1"
CALL CALL SET "$=%%%%%~1[%%%~1%%]%%%%"
CALL SET "%~1[%%%~1%%]="
GOTO :EOF

::�����ȡ
::  ����1: ������
::  ����2: ������(��ѡ,Ĭ�����һ��)
:GET
SET "$=%~2"
IF "%$%" == "" CALL SET /A "$=%%%~1%% - 1"
CALL SET "$=%%%~1[%$%]%%"
GOTO :EOF

::�������
::  ����1: ������
::  ����2: �ص�����({K}�����������, {V}�����������)
:EACH
SET /A "$=!%~1! - 1"
FOR /L %%I IN (0,1,%$%) DO (
    SET "$=%~2"
    CALL SET "$=%%$:{K}=%%~I%%"
    CALL SET "$=%%$:{V}=!%~1[%%I]!%%"
    CALL %%$%%
)
GOTO :EOF

::��������
::  ����1: ������
:SORT
SET /A "$LAST=!%~1! - 1"
FOR /L %%I IN (1,1,!$LAST!) DO (
  FOR /L %%J IN (!$LAST!,-1,%%I) DO (
    SET /A "$PREV=%%J - 1"
    CALL CALL SET "$=%%%%%~1[%%$PREV%%]%%%%"
    IF "!$!" GTR "!%~1[%%J]!" (
      CALL SET "%~1[%%$PREV%%]=%%%~1[%%J]%%"
      CALL SET "%~1[%%J]=%%$%%"
    )
  )
)
SET "$PREV="
SET "$LAST="
GOTO :EOF