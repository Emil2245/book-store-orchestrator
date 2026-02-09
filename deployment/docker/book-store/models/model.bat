@echo off
echo Descargando modelo Llama 3.2 3B Instruct...

curl -L ^
"https://huggingface.co/hugging-quants/Llama-3.2-3B-Instruct-Q4_K_M-GGUF/resolve/main/llama-3.2-3b-instruct-q4_k_m.gguf?download=true" ^
-o llama-3.2-3b-instruct-q4_k_m.gguf

echo.
echo Descarga completada.
pause
