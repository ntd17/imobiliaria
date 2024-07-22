<jsp:include page="cabecalho.jsp" />

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.*"%> 
<%@page import="java.text.NumberFormat"%> 


<%
    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    Statement st3 = null;
    ResultSet rs3 = null;

    Statement st4 = null;
    ResultSet rs4 = null;

    String status = "";
    String imagem = "";
    String valor = "";
    String titulo = "";
    String bairro = "";
    String areaInicio = "";
    String areaFinal = "";
    String valorInicio = "";
    String valorFinal = "";
    String area = "";
    String quartos = "";
    String banheiros = "";
    String garagens = "";
    String corretor = "";
    String id = "";

    String cidade = "";
    String tipo = "";
    String condicao = "";
    String valorCompra = "";
    String valorAluguel = "";

    String nomeCorretor = "";
    String telefoneCorretor = "";
    String imgCorretor = "";
    String nomeBairro = "";

    String classe = "";

    String textowhats = "Olá, vi seu contato no site IMOB e gostaria de mais informações!!";

//recuperar os dados da busca
    status = request.getParameter("status-form");
    cidade = request.getParameter("cidade");
    bairro = request.getParameter("bairro");
    condicao = request.getParameter("condicao");
    tipo = request.getParameter("tipo");
    quartos = request.getParameter("quartos");
    garagens = request.getParameter("garagem");
    areaInicio = request.getParameter("tamanhoMenor");
    areaFinal = request.getParameter("tamanhoMaior");

    if (status != null) {
        if (status.equals("Venda")) {
            status = "Para Venda";
        } else {
            status = "Para Aluguel";
        }

        if (status.equals("Para Venda")) {
            valorInicio = request.getParameter("valorMenorCompra");
            valorFinal = request.getParameter("valorMaiorCompra");
        } else {
            valorInicio = request.getParameter("valorMenorAluguel");
            valorFinal = request.getParameter("valorMaiorAluguel");
        }
    }


%>




<!-- Property Section Begin -->
<section class="property-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h4>IMÓVEIS RECENTES</h4>
                </div>
            </div>
        </div>
        <div class="row">

            <!-- Início dos cards -->

            <%                        try {

                    st = new Conexao().conectar().createStatement();
                    st2 = new Conexao().conectar().createStatement();
                    st3 = new Conexao().conectar().createStatement();

                    if (request.getParameter("tipo-imovel") != null) {
                        String idTipo = "";
                        idTipo = request.getParameter("tipo-imovel");
                        rs = st.executeQuery("SELECT * FROM imoveis where tipo = '" + idTipo + "' order by id desc ");

                    } else {
                        if (quartos.equals("mais") && garagens.equals("mais")) {
                            rs = st.executeQuery("SELECT * FROM imoveis where status LIKE '%" + status + "%' and cidade = '" + cidade + "' and bairro LIKE '%" + bairro + "%' and tipo LIKE '%" + tipo + "%' and quartos >= 6 and garagens >= 6 and condicao LIKE '%" + condicao + "%' and area >= '" + areaInicio + "' and area <= '" + areaFinal + "' and valor >= '" + valorInicio + "' and valor <= '" + valorFinal + "' order by id desc ");

                        } else if (quartos.equals("mais") && !garagens.equals("mais")) {
                            rs = st.executeQuery("SELECT * FROM imoveis where status LIKE '%" + status + "%' and cidade = '" + cidade + "' and bairro LIKE '%" + bairro + "%' and tipo LIKE '%" + tipo + "%' and quartos >= 6 and garagens LIKE '%" + garagens + "%' and condicao LIKE '%" + condicao + "%' and area >= '" + areaInicio + "' and area <= '" + areaFinal + "' and valor >= '" + valorInicio + "' and valor <= '" + valorFinal + "' order by id desc ");

                        } else if (!quartos.equals("mais") && garagens.equals("mais")) {
                            rs = st.executeQuery("SELECT * FROM imoveis where status LIKE '%" + status + "%' and cidade = '" + cidade + "' and bairro LIKE '%" + bairro + "%' and tipo LIKE '%" + tipo + "%' and quartos LIKE '%" + quartos + "%' and garagens >= 6 and condicao LIKE '%" + condicao + "%' and area >= '" + areaInicio + "' and area <= '" + areaFinal + "' and valor >= '" + valorInicio + "' and valor <= '" + valorFinal + "' order by id desc ");

                        } else {
                            rs = st.executeQuery("SELECT * FROM imoveis where status LIKE '%" + status + "%' and cidade = '" + cidade + "' and bairro LIKE '%" + bairro + "%' and tipo LIKE '%" + tipo + "%' and quartos LIKE '%" + quartos + "%' and garagens LIKE '%" + garagens + "%' and condicao LIKE '%" + condicao + "%' and area >= '" + areaInicio + "' and area <= '" + areaFinal + "' and valor >= '" + valorInicio + "' and valor <= '" + valorFinal + "' order by id desc ");

                        }
                    }

                    while (rs.next()) {
                        status = rs.getString(22);
                        imagem = rs.getString(18);
                        valor = rs.getString(9);
                        titulo = rs.getString(4);
                        bairro = rs.getString(8);
                        area = rs.getString(12);
                        quartos = rs.getString(13);
                        banheiros = rs.getString(14);
                        garagens = rs.getString(16);
                        corretor = rs.getString(3);
                        
                         double vlr = 0;
                        vlr = Double.parseDouble(valor);
                        valor = (NumberFormat.getCurrencyInstance().format(vlr));

                        id = rs.getString(1);

                        rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "'");
                        while (rs2.next()) {
                            nomeCorretor = rs2.getString(2);
                            telefoneCorretor = rs2.getString(4);
                            imgCorretor = rs2.getString(7);
                        }

                        rs3 = st3.executeQuery("SELECT * FROM bairros where id = '" + bairro + "'");
                        while (rs3.next()) {
                            nomeBairro = rs3.getString(2);

                        }

                        if (status.equals("Para Venda")) {
                            classe = "c-red";
                        } else {
                            classe = "";
                        }

                        int i = 0;

                        try {

                            //BUSCAR TODOS OS CURSOS PARA SABER O TOTAL DE CURSOS PARA DIVIDIR EM PÁGINAS
                            st4 = new Conexao().conectar().createStatement();
                            rs4 = st4.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel'");
                            while (rs4.next()) {

                                i = i + 1;
                            }
                        } catch (Exception e) {
                            out.print(e);
                        }


            %>

            <div class="col-lg-4 col-md-6 mix all house">
                <div class="property-item">
                    <a href="imovel-detalhes.jsp?id=<%=id%>">
                        <div class="pi-pic set-bg" data-setbg="sistema/img/imoveis/<%=imagem%>">
                            <div class="label <%=classe%>"><%=status%></div>
                        </div>
                    </a>
                    <div class="pi-text">
                        <a title="Enviar Mensagem" href="" data-toggle="modal" data-target="#modalMensagemImovel" class="heart-icon"><span class="icon_heart_alt"></span></a>
                        <div class="pt-price"><%=valor%>
                            <%if (status.equals("Para Aluguel")) {
                                    out.print("<span>/mes</span>");
                                }%>

                        </div>
                        <h5><a href="imovel-detalhes.jsp?id=<%=id%>"><%=titulo%></a></h5>
                        <p><span class="icon_pin_alt"></span> <%=nomeBairro%></p>
                        <ul>
                            <li><i class="fa fa-object-group"></i> <%=area%> m²</li>
                            <li><i class="fa fa-bathtub"></i> <%=banheiros%></li>
                            <li><i class="fa fa-bed"></i> <%=quartos%></li>
                            <li><i class="fa fa-automobile"></i> <%=garagens%></li>
                        </ul>
                        <div class="pi-agent">
                            <div class="pa-item">
                                <div class="pa-info">
                                    <img src="sistema/img/profiles/<%=imgCorretor%>" alt="">
                                    <h6><%=nomeCorretor%></h6>
                                </div>
                                <div class="pa-text">
                                    <a class="cor-verde-template-link" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=55<%=telefoneCorretor%>"><i class="fa fa-whatsapp"></i> <%=telefoneCorretor%> </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <%  }
                } catch (Exception e) {
                    out.print(e);
                }
            %>



            <!-- Fim dos Cards com os Imóveis --> 


            <jsp:include page="rodape.jsp" />  