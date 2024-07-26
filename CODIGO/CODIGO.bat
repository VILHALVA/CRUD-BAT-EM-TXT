@echo off
setlocal enabledelayedexpansion

set "arquivo=usuarios.txt"

if not exist "%arquivo%" (
    echo.>"%arquivo%"
)

:adicionar_usuario
set /p "nome=DIGITE O NOME: "
set /p "idade=DIGITE A IDADE: "
echo %nome%,%idade% >> "%arquivo%"
echo USUARIO ADICIONADO COM SUCESSO!
goto menu

:listar_usuarios
cls
if exist "%arquivo%" (
    echo  ========== LISTA DE USUARIOS ==========
    echo ******************************
    for /f "tokens=1,2 delims=," %%a in (%arquivo%) do (
        echo NOME: %%a, IDADE: %%b
        echo ******************************
    )
    echo =========================================
) else (
    echo NENHUM USUARIO CADASTRADO.
)
pause
goto menu

:atualizar_usuario
set /p "nome_antigo=DIGITE O NOME A SER ATUALIZADO: "
set /p "novo_nome=DIGITE O NOVO NOME: "
set /p "nova_idade=DIGITE A NOVA IDADE: "
set "existe=0"

(
    for /f "tokens=1,2 delims=," %%a in (%arquivo%) do (
        if "%%a"=="%nome_antigo%" (
            echo %novo_nome%,%nova_idade%
            set "existe=1"
        ) else (
            echo %%a,%%b
        )
    )
) > "%arquivo%.tmp"
move /y "%arquivo%.tmp" "%arquivo%"

if %existe%==1 (
    echo USUARIO ATUALIZADO COM SUCESSO!
) else (
    echo USUARIO NAO ENCONTRADO.
)
goto menu

:excluir_usuario
set /p "nome=DIGITE O NOME DO USUARIO A SER EXCLUIDO: "
set "excluido=0"

(
    for /f "tokens=1,2 delims=," %%a in (%arquivo%) do (
        if "%%a"=="%nome%" (
            set "excluido=1"
        ) else (
            echo %%a,%%b
        )
    )
) > "%arquivo%.tmp"
move /y "%arquivo%.tmp" "%arquivo%"

if %excluido%==1 (
    echo USUARIO EXCLUIDO COM SUCESSO!
) else (
    echo USUARIO NAO ENCONTRADO.
)
goto menu

:menu
cls
echo MENU:
echo 1. ADICIONAR USUARIO
echo 2. LISTAR USUARIOS
echo 3. ATUALIZAR USUARIO
echo 4. EXCLUIR USUARIO
echo 5. SAIR
set /p "opcao=ESCOLHA UMA OPCAO: "

if "%opcao%"=="1" goto adicionar_usuario
if "%opcao%"=="2" goto listar_usuarios
if "%opcao%"=="3" goto atualizar_usuario
if "%opcao%"=="4" goto excluir_usuario
if "%opcao%"=="5" (
    echo SAINDO...
    timeout /t 3 /nobreak >nul
    exit
)

echo OPCAO INVALIDA. TENTE NOVAMENTE!
goto menu
