<%@page import="util.*"%> 
<%
    
    
    String mensagemUsuario = null;
    String emailCorretor = request.getParameter("emailCorretor");
    
    if(request.getParameter("txtNome") == ""){
        out.print("Preencha o Campo Nome");
        return;
    }

    EnviarEmail enviar = new EnviarEmail();
    enviar.setEmailDestinatario(emailCorretor);
    enviar.setAssunto(new Config().nomeDaImobiliaria);
    //uso StringBuffer para otimizar a concatenação 
    //de string
    StringBuffer texto = new StringBuffer();

    texto.append("<b>Nome:</b> ");
    texto.append(request.getParameter("txtNome"));
    texto.append("<br/>");
    texto.append("<b>Email</b> ");
    texto.append(request.getParameter("txtEmail"));
    texto.append("<br/>");
    texto.append("<b>Telefone</b> ");
    texto.append(request.getParameter("txtTelefone"));
    texto.append("<br/>");
    texto.append("<b>Mensagem:</b><br/> ");
    texto.append(request.getParameter("txtMensagem"));

    enviar.setMsg(texto.toString());

    boolean enviou = enviar.enviar();
    if (enviou) {

        mensagemUsuario = "Dados enviados com sucesso";

    } else {
        mensagemUsuario = "Não foi possível enviar as informações";

    }
    
    out.print(mensagemUsuario);


%>     