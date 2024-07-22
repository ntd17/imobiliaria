<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="util.Conexao"%>

<%
    Statement st = null;
    ResultSet rs = null;

    String nome = "";
    String cpf = "";
    String telefone = "";
    String email = "";
    String endereco = "";
    String imagem = null;

    String id = "";
    String antigo = "";

    Upload up = new Upload();

    // Definir qual a pasta a ser salva
    up.setFolderUpload("sistema/img/profiles");

    if (up.formProcess(getServletContext(), request)) {
        try {
            nome = up.getForm().get("nome").toString();
            cpf = up.getForm().get("cpf").toString();
            telefone = up.getForm().get("telefone").toString();
            email = up.getForm().get("email").toString();
            endereco = up.getForm().get("endereco").toString();
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();
            imagem = up.getFiles().get(0).toString();
        } catch (Exception e) {
            imagem = "sem-foto.jpg";
        }

        // Inserir os dados no banco de dados
        try {
            // Verificar se o campo é vazio
            if (nome.equals("")) {
                out.print("Preencha o Campo Nome!");
                return;
            }

            if (cpf.equals("")) {
                out.print("Preencha o Campo CPF!");
                return;
            }

            st = new Conexao().conectar().createStatement();

            // Verificar se já existe um registro com este dado no banco
            if (!cpf.equals(antigo)) {
                rs = st.executeQuery("SELECT * FROM corretores where cpf = '" + cpf + "'");
                while (rs.next()) {
                    if (rs.getRow() > 0) {
                        out.print("CPF já Cadastrado!");
                        return;
                    }
                }
            }

            if (id.equals("")) {
                st.executeUpdate("INSERT into corretores (nome, cpf, telefone, email, endereco, foto) values ('" + nome + "', '" + cpf + "' , '" + telefone + "' , '" + email + "', '" + endereco + "', '" + imagem + "')");
                st.executeUpdate("INSERT into usuarios (nome, cpf, email, senha, nivel, foto) values ('" + nome + "', '" + cpf + "', '" + email + "', '123', 'corretor', '" + imagem + "')");
            } else {
                if (imagem.equals("sem-foto.jpg")) {
                    st.executeUpdate("UPDATE corretores SET nome = '" + nome + "', cpf = '" + cpf + "', telefone = '" + telefone + "', email = '" + email + "', endereco = '" + endereco + "' WHERE id = '" + id + "'");
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "' WHERE cpf = '" + antigo + "'");
                } else {
                    st.executeUpdate("UPDATE corretores SET nome = '" + nome + "', cpf = '" + cpf + "', telefone = '" + telefone + "', email = '" + email + "', endereco = '" + endereco + "', foto = '" + imagem + "' WHERE id = '" + id + "'");
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "', foto = '" + imagem + "' WHERE cpf = '" + antigo + "'");
                }
            }

            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }
    }
%>