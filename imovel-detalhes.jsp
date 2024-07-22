<jsp:include page="cabecalho.jsp" /> 

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.*"%> 
<%@page import="java.text.NumberFormat"%> 

<%
    String id = request.getParameter("id");

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
    String imagemPlanta = "";
    String valor = "";
    String titulo = "";
    String bairro = "";
    String area = "";
    String quartos = "";
    String banheiros = "";
    String garagens = "";
    String corretor = "";
    String tipo = "";
    String descricao = "";
    String suites = "";
    String piscinas = "";
    String ano = "";
    String condicao = "";

    String nomeCorretor = "";
    String emailCorretor = "";
    String telefoneCorretor = "";
    String imgCorretor = "";
    String nomeBairro = "";
    String nomeTipo = "";

    String classe = "";

    String textowhats = "Olá, vi seu contato no site IMOB e gostaria de mais informações!!";


%>


<%    try {

        st = new Conexao().conectar().createStatement();
        st2 = new Conexao().conectar().createStatement();
        st3 = new Conexao().conectar().createStatement();
        st4 = new Conexao().conectar().createStatement();

        rs = st.executeQuery("SELECT * FROM imoveis where id = '" + id + "' ");
        while (rs.next()) {
            status = rs.getString(22);
            imagem = rs.getString(18);
            imagemPlanta = rs.getString(19);
            valor = rs.getString(9);
            titulo = rs.getString(4);
            bairro = rs.getString(8);
            area = rs.getString(12);
            quartos = rs.getString(13);
            banheiros = rs.getString(14);
            garagens = rs.getString(16);
            corretor = rs.getString(3);
            tipo = rs.getString(6);
            descricao = rs.getString(5);
            suites = rs.getString(15);
            piscinas = rs.getString(17);
            ano = rs.getString(10);
            condicao = rs.getString(23);
            
             double vlr = 0;
                        vlr = Double.parseDouble(valor);
                        valor = (NumberFormat.getCurrencyInstance().format(vlr));

            rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "'");
            while (rs2.next()) {
                nomeCorretor = rs2.getString(2);
                telefoneCorretor = rs2.getString(4);
                imgCorretor = rs2.getString(7);
                emailCorretor = rs2.getString(5);
            }

            rs3 = st3.executeQuery("SELECT * FROM bairros where id = '" + bairro + "'");
            while (rs3.next()) {
                nomeBairro = rs3.getString(2);

            }

            rs4 = st4.executeQuery("SELECT * FROM tipos where id = '" + tipo + "'");
            while (rs4.next()) {
                nomeTipo = rs4.getString(2);

            }

            if (status.equals("Para Venda")) {
                classe = "c-red";
            } else {
                classe = "";
            }

            int i = 0;

        }

    } catch (Exception e) {
        out.print(e);
    }
%>

<!-- Property Details Section Begin -->
<section class="property-details-section">

    <div class="fp-slider owl-carousel mb-4">

        <%
            try {
                String img_imovel = "";

                st = new Conexao().conectar().createStatement();

                rs = st.executeQuery("SELECT * FROM imagens where id_imovel = '" + id + "' ");
                while (rs.next()) {
                    img_imovel = rs.getString(3);%>

        <!-- Inicio do Carrousel -->
        <div class="fp-item set-bg" data-setbg="sistema/img/imoveis/<%=img_imovel%>"> </div>

        <!-- Final do Carrousel -->

        <% }

            } catch (Exception e) {
                out.print(e);
            }

        %>


    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <div class="pd-text">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="pd-title">

                                <div class="label <%=classe%>"><%=status%></div>
                                <div class="pt-price"><%=valor%>
                                    <%if (status.equals("Para Aluguel")) {
                                            out.print("<span>/mes</span>");
                                        }%>

                                </div>
                                <h3><%=titulo%></h3>
                                <p><span class="icon_pin_alt"></span> <%=nomeBairro%></p>
                            </div>
                        </div>
                        <div class="col-lg-6">

                        </div>
                    </div>
                    <div class="pd-board">
                        <div class="tab-board">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Detalhes</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Descrição</a>
                                </li>

                            </ul><!-- Tab panes -->
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                    <div class="tab-details">
                                        <ul class="left-table">
                                            <li>
                                                <span class="type-name">Tipo Imóvel</span>
                                                <span class="type-value"><%=nomeTipo%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Código Imóvel</span>
                                                <span class="type-value"><%=id%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Valor</span>
                                                <span class="type-value"><%=valor%>
                                                    <%if (status.equals("Para Aluguel")) {
                                                            out.print("<span>/mes</span>");
                                                        }%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Ano Construção</span>
                                                <span class="type-value"><%=ano%> - Imóvel <%=condicao%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Total de Visitas</span>
                                                <span class="type-value">65</span>
                                            </li>
                                            <li>
                                                <span class="type-name">Corretor</span>
                                                <span class="type-value"><%=nomeCorretor%></span>
                                            </li>
                                        </ul>
                                        <ul class="right-table">
                                            <li>
                                                <span class="type-name">Área</span>
                                                <span class="type-value"><%=area%> m²</span>
                                            </li>
                                            <li>
                                                <span class="type-name">Quartos</span>
                                                <span class="type-value"><%=quartos%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Banheiros</span>
                                                <span class="type-value"><%=banheiros%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Suítes</span>
                                                <span class="type-value"><%=suites%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Garagens</span>
                                                <span class="type-value"><%=garagens%></span>
                                            </li>
                                            <li>
                                                <span class="type-name">Piscina</span>
                                                <span class="type-value"><%=piscinas%></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-2" role="tabpanel">
                                    <div class="tab-desc">
                                        <p><%=descricao%></p>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-3" role="tabpanel">
                                    <div class="tab-details">


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%if (!imagemPlanta.equals("sem-img.jpg")) {%>

                    <div class="pd-widget">
                        <h4>Planta do Imóvel</h4>
                        <img src="sistema/img/imoveis/<%=imagemPlanta%>" alt="">
                    </div>

                    <% }%>


               

                    <div class="pd-widget">
                        <h4>Deseja Visitar?</h4>
                        <form method="post" class="review-form">
                            <div class="group-input">
                                <input type="text" name="txtNome" placeholder="Nome">
                                <input id="telefone" name="txtTelefone" type="text" placeholder="Telefone">
                                <input type="email" name="txtEmail" placeholder="Email">
                                
                                <input type="hidden" value="<%=emailCorretor%>" name="emailCorretor">

                            </div>
                            <textarea name="txtMensagem" placeholder="Comentário"></textarea>
                            <div class="rating">
                                <span>Avaliações:</span>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <button id="btn-enviar" type="submit" class="site-btn">Enviar</button>
                        </form>
                                <small><div id="mensagem-email" align="center">                 
                        </div></small>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="property-sidebar">
                    <div class="single-sidebar">
                        <div class="section-title sidebar-title">
                            <h5>Corretor</h5>
                        </div>
                        <div class="top-agent">
                            <div class="ta-item">
                                <div class="ta-pic set-bg" data-setbg="sistema/img/profiles/<%=imgCorretor%>"></div>
                                <div class="ta-text">
                                    <h6><%=nomeCorretor%></h6>
                                    <span>Especialista em Imóveis</span>
                                    <div class="ta-num"><a class="cor-verde-template-link" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=55<%=telefoneCorretor%>"><i class="fa fa-whatsapp mr-1"></i><%=telefoneCorretor%></a></div>
                                </div>
                            </div>


                        </div>
                    </div>
                    <div class="single-sidebar slider-op">
                        <div class="section-title sidebar-title">
                            <h5>Imóveis Relacionados</h5>
                        </div>
                        <div class="sf-slider owl-carousel">

                            <%
                                try {
                                    String id2 = "";
                                    String imagem2 = "";
                                    String valor2 = "";
                                    String titulo2 = "";
                                    
                                   
                                    st = new Conexao().conectar().createStatement();

                                    rs = st.executeQuery("SELECT * FROM imoveis where tipo = '" + tipo + "' and status = '" + status + "' order by id desc LIMIT 4 ");
                                    while (rs.next()) {

                                        imagem2 = rs.getString(18);
                                        valor2 = rs.getString(9);
                                        titulo2 = rs.getString(4);
                                        
                                         double vlr = 0;
                        vlr = Double.parseDouble(valor2);
                        valor2 = (NumberFormat.getCurrencyInstance().format(vlr));


                                        id2 = rs.getString(1);%>
                            <a href="imovel-detalhes.jsp?id=<%=id2%>">
                                <div class="sf-item set-bg" data-setbg="sistema/img/imoveis/<%=imagem2%>">
                                    <div class="sf-text">
                                        <h5><%=titulo2%></h5>
                                        <span><%=valor2%></span>
                                    </div>
                                </div>
                            </a>

                            <%  }
                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>


                        </div>
                    </div>

                    <div class="single-sidebar slider-op">
                        <div class="section-title sidebar-title">
                            <h5>Tipos de Imóveis</h5>
                        </div>
                        <div class="sf-slider owl-carousel">

                            <%
                                try {
                                    String id2 = "";
                                    String imagem2 = "";

                                    String titulo2 = "";

                                    st = new Conexao().conectar().createStatement();

                                    rs = st.executeQuery("SELECT * FROM tipos");
                                    while (rs.next()) {

                                        imagem2 = rs.getString(3);
                                        titulo2 = rs.getString(2);
                                        id2 = rs.getString(1);

                                        st2 = new Conexao().conectar().createStatement();

                                        rs2 = st2.executeQuery("SELECT * FROM imoveis where tipo = '" + id2 + "' and (status = 'Para Venda' or status = 'Para Aluguel') ");
                                        int quant = 0;
                                        while (rs2.next()) {
                                            quant = quant + 1;
                                        }

                            %>



                            <div class="sf-item set-bg" data-setbg="sistema/img/imoveis/<%=imagem2%>">
                                <div class="sf-text">
                                    <h5><%=titulo2%></h5>
                                    <span><%=quant%> Imóveis</span>
                                </div>
                            </div>
                            <%  }
                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>


                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</section>
<!-- Property Details Section End -->


<jsp:include page="rodape.jsp" /> 




<!--AJAX PARA INSERÇÃO DOS DADOS -->
<script type="text/javascript">
    $(document).ready(function () {
        
        $('#btn-enviar').click(function (event) {
            $('#mensagem-email').addClass('text-info')
            $('#mensagem-email').text("Enviando!!")
            event.preventDefault();
            
            $.ajax({
                url: "enviar-email.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    $('#mensagem-email').removeClass()

                    if (mensagem.trim() == "Dados enviados com sucesso") {
                        $('#mensagem-email').addClass('text-success')
                        
                    } else {

                        $('#mensagem-email').addClass('text-danger')
                       
                    }

                    $('#mensagem-email').text(mensagem)

                },

            })
        })
    })
</script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="js/mascara.js"></script>
