# Info_Sistemas
Este repositório é destinado ao projeto de avaliação para vaga de desenvolvedor Delphi na empresa Info Sistemas.

## Tecnologias

### Delphi
- Este projeto foi criado na IDE Delphi 2010 (Não licenciada);
- Não foi utilizado componentes de terceiros

### Java
O Java foi utilizado para suprir uma deficiência do componente INDY do Delphi que ao enviar e-mail estava gerando erro ao utilizar SSL.
- Versão 1.8.0_151
- Maven 3.6.3
 
## Execução do projeto
- Faz parte do executável do projeto os seguintes ítens:
    - Arquivos:
        - Avaliacao.exe
        - ssleay32.dll - Biblioteca utilizada pelo componente Indy
        - libeay32.dll - Biblioteca utilizada pelo componente Indy
        - smtp_conf.ini - Arquivo de configuração para autenticação da conta de e-mail
    - Pastas:
        - assets - Contém os arquivos de images necessários, bem como a fonte utilizada. Obs.: A Fonte "Font Awesome 6 Free-Solid-900.otf" deve ser disponibilizada na Pasta "C:\Windows\Fonts"
        - bin - Pasta que contém o arquivo jar que faz o envio do e-mail, juntamente com suas duas bibliotecas auxiliares.
