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

    String status = "";
    String imagem = "";
    String valor = "";
    String titulo = "";
    String bairro = "";
    String area = "";
    String quartos = "";
    String banheiros = "";
    String garagens = "";
    String corretor = "";
    String id = "";

    String nomeCorretor = "";
    String telefoneCorretor = "";
    String imgCorretor = "";
    String nomeBairro = "";

    String classe = "";

    String textowhats = "Olá, vi seu contato no site imobiliário e gostaria de mais informações!!";

    st = new Conexao().conectar().createStatement();
    st2 = new Conexao().conectar().createStatement();
    st3 = new Conexao().conectar().createStatement();


%>

<!--SlideShow Carroussel -->
<section class="hero-section">
    <div class="container">
        <div class="hs-slider owl-carousel">


            <%                try {

                    rs = st.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel' order by id desc limit 4");
                    while (rs.next()) {
                        status = rs.getString(22);
                        imagem = rs.getString(20);
                        valor = rs.getString(9);
                        titulo = rs.getString(4);
                        bairro = rs.getString(8);
                        area = rs.getString(12);
                        quartos = rs.getString(13);
                        banheiros = rs.getString(14);
                        garagens = rs.getString(16);
                        corretor = rs.getString(3);

                        id = rs.getString(1);
                        double vlr = 0;
                        vlr = Double.parseDouble(valor);
                        valor = (NumberFormat.getCurrencyInstance().format(vlr));

                        rs3 = st3.executeQuery("SELECT * FROM bairros where id = '" + bairro + "'");
                        while (rs3.next()) {
                            nomeBairro = rs3.getString(2);

                        }

                        if (status.equals("Para Venda")) {
                            classe = "c-red";
                        } else {
                            classe = "";
                        }
            %>


            <div class="hs-item set-bg" data-setbg="sistema/img/imoveis/<%=imagem%>">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="hc-inner-text">
                            <div class="hc-text">
                                <h4><%=titulo%></h4>
                                <p><span class="icon_pin_alt"></span> <%=nomeBairro%></p>
                                <div class="label <%=classe%>"><%=status%></div>
                                <h5><%=valor%><span><%if (status.equals("Para Aluguel")) {
                                        out.print("<span>/m�s</span>");
                                    }%></span></h5>
                            </div>
                            <div class="hc-widget">
                                <ul>
                                    <li><i class="fa fa-object-group"></i> <%=area%>m�</li>
                                    <li><i class="fa fa-bathtub"></i> <%=banheiros%></li>
                                    <li><i class="fa fa-bed"></i> <%=quartos%></li>
                                    <li><i class="fa fa-automobile"></i> <%=garagens%></li>
                                </ul>
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

        </div>
    </div>
</section>
<!-- Final do Slideshow -->

<!--Filtro por Im�veis -->
<section class="search-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-7">
                <div class="section-title">
                    <h4>Qual im�vel est� Procurando?</h4>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="change-btn">
                    <div class="cb-item">
                        <label for="cb-rent" class="btn btn-warning">
                            Compra
                            <input type="radio" id="cb-rent">
                        </label>
                    </div>
                    <div class="cb-item">
                        <label for="cb-sale" class="btn btn-danger">
                            Aluguel
                            <input type="radio" id="cb-sale">
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="search-form-content">
            <form action="lista-imoveis.jsp" method="GET" class="filter-form">
                <input type="hidden" id="status-form" name="status-form">
                <select class="sm-width" name="cidade" id="cidade">
                    <%
                        st = new Conexao().conectar().createStatement();
                        rs = st.executeQuery("SELECT * FROM cidades order by nome asc");

                        while (rs.next()) {
                            out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");

                        }
                    %>

                </select>

                <span id="listar-bairros"></span>
                <input value="teste" type="hidden" name="txtcidade" id="txtcidade">



                <select class="sm-width" name="condicao">
                    <option value="">Im�vel Status</option>
                    <option value="Novo">Novo</option>
                    <option value="Planta">Planta</option>
                    <option value="Usado">Usado</option>
                </select>
                <select class="sm-width" name="tipo">
                    <option value="">Tipo do Im�vel</option>
                    <%
                        st = new Conexao().conectar().createStatement();
                        rs = st.executeQuery("SELECT * FROM tipos order by nome asc");

                        while (rs.next()) {
                            out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");

                        }
                    %>
                </select>
                <select class="sm-width" name="quartos">
                    <option value="">N�mero de Quartos</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="mais">Mais de 5</option>
                </select>
                <select class="sm-width" name="garagem">
                    <option value="">Vagas de Garagem</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="mais">Mais de 5</option>
                </select>


                <div class="room-size-range-wrap sm-width">
                    <div class="price-text">
                        <label for="roomsizeRange">Tamanho m�:</label>
                        <input type="text" id="roomsizeRange" name="area" readonly>
                        <input type="hidden" id="tamanhoMenor" name="tamanhoMenor">
                        <input type="hidden" id="tamanhoMaior" name="tamanhoMaior">
                    </div>
                    <div id="roomsize-range" class="slider"></div>

                </div>


                <div id="priceCompra" class="price-range-wrap sm-width">
                    <div class="price-text">
                        <label for="priceRange">Valor:</label>
                        <input type="text" id="priceRange" name="valorCompra" readonly>
                        <input type="hidden" id="valorMenorCompra" name="valorMenorCompra">
                        <input type="hidden" id="valorMaiorCompra" name="valorMaiorCompra">
                    </div>
                    <div id="price-range" class="slider"></div>
                </div>


                <div id="priceAluguel" class="price-range-wrap sm-width">
                    <div class="price-text">
                        <label for="priceRange">Valor:</label>
                        <input type="text" id="priceRangeAluguel" name="valorAluguel" readonly>
                        <input type="hidden" id="valorMenorAluguel" name="valorMenorAluguel">
                        <input type="hidden" id="valorMaiorAluguel" name="valorMaiorAluguel">
                    </div>
                    <div id="price-range-aluguel" class="slider"></div>
                </div>



                <button type="submit" class="search-btn sm-width">Buscar</button>
            </form>
        </div>

    </div>
</section>
<!-- Search Section End -->

<!-- Property Section Begin -->
<section class="property-section latest-property-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-5">
                <div class="section-title">
                    <h4>ULTIMOS IM�VEIS</h4>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="property-controls">
                    <ul>
                        <li id="listarTodos" data-filter="all">Todos</li>
                            <%
                                st = new Conexao().conectar().createStatement();
                                String nomeTipo = "";
                                String idTipo = "";
                                rs = st.executeQuery("SELECT * FROM tipos order by imoveis desc limit 5 ");
                                while (rs.next()) {

                                    nomeTipo = rs.getString(2);
                                    idTipo = rs.getString(1);

                                    out.print("<li><a class='text-secondary' href='lista-imoveis.jsp?tipo-imovel=" + idTipo + "'>" + nomeTipo + "</a></li>");
                                }
                            %>


                    </ul>
                </div>
            </div>
        </div>



        <div class="row property-filter">

            <!-- In�cio dos cards -->

            <%    try {

                    rs = st.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel' order by id desc limit 6");
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
                            <li><i class="fa fa-object-group"></i> <%=area%> m�</li>
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

            <!-- Fim dos Cards com os Im�veis -->   

        </div>
    </div>
</section>
<!-- Property Section End -->

<!-- Chooseus Section Begin -->
<section class="chooseus-section spad set-bg" data-setbg="img/chooseus/chooseus-bg.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <div class="chooseus-text">
                    <div class="section-title">
                        <h4>Invista no seu futuro!</h4>
                    </div>
                    <p>Lorem Ipsum has been the industry?s standard dummy text ever since the 1500s, when an unknown
                        printer took a galley of type and scrambled it to make a type specimen book.</p>
                </div>
                <div class="chooseus-features">
                    <div class="cf-item">
                        <div class="cf-pic">
                            <img src="img/chooseus/chooseus-icon-1.png" alt="">
                        </div>
                        <div class="cf-text">
                            <h5>Os Melhores Im�veis</h5>
                            <p>We help you find a new home by offering a smart real estate.</p>
                        </div>
                    </div>
                    <div class="cf-item">
                        <div class="cf-pic">
                            <img src="img/chooseus/chooseus-icon-2.png" alt="">
                        </div>
                        <div class="cf-text">
                            <h5>Sua compra Facilitada</h5>
                            <p>Millions of houses and apartments in your favourite cities</p>
                        </div>
                    </div>
                    <div class="cf-item">
                        <div class="cf-pic">
                            <img src="img/chooseus/chooseus-icon-3.png" alt="">
                        </div>
                        <div class="cf-text">
                            <h5>Corretores Especializados</h5>
                            <p>Find an agent who knows your market best</p>
                        </div>
                    </div>
                    <div class="cf-item">
                        <div class="cf-pic">
                            <img src="img/chooseus/chooseus-icon-4.png" alt="">
                        </div>
                        <div class="cf-text">
                            <h5>Melhores Localiza��es</h5>
                            <p>Sign up now and sell or rent your own properties</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Chooseus Section End -->

<!-- Feature Property Section Begin -->
<section class="feature-property-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 p-0">
                <div class="feature-property-left">
                    <div class="section-title">
                        <h4>Categorias</h4>
                    </div>
                    <ul>
                        <%
                            st = new Conexao().conectar().createStatement();
                            String nomeTipo2 = "";
                            String idTipo2 = "";
                            rs = st.executeQuery("SELECT * FROM tipos order by imoveis desc limit 6 ");
                            while (rs.next()) {

                                nomeTipo2 = rs.getString(2);
                                idTipo2 = rs.getString(1);

                                out.print("<li><a class='linkul' href='lista-imoveis.jsp?tipo-imovel=" + idTipo2 + "'>" + nomeTipo2 + "</a></li>");
                            }
                        %>
                    </ul>
                    <a class="linkcategorias" href="imoveis.jsp">Ver Todos Im�veis</a>
                </div>
            </div>
            <div class="col-lg-8 p-0">
                <div class="fp-slider owl-carousel">

                    <%    try {

                            rs = st.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel' order by valor asc limit 5");
                            while (rs.next()) {
                                status = rs.getString(22);
                                imagem = rs.getString(20);
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

                    %>

                    <!-- Inicio do Carrousel -->
                    <div class="fp-item set-bg" data-setbg="sistema/img/imoveis/<%=imagem%>">
                        <div class="fp-text">
                            <h5 class="title"><%=titulo%></h5>
                            <p><span class="icon_pin_alt"></span> <%=nomeBairro%></p>
                            <div class="label <%=classe%>"><%=status%></div>
                            <h5><%=valor%><span><%if (status.equals("Para Aluguel")) {
                                    out.print("<span>/mes</span>");
                                }%></span></h5>
                            <ul>
                                <li><i class="fa fa-object-group"></i> <%=area%>m�</li>
                                <li><i class="fa fa-bathtub"></i> <%=banheiros%></li>
                                <li><i class="fa fa-bed"></i> <%=quartos%></li>
                                <li><i class="fa fa-automobile"></i> <%=garagens%></li>
                            </ul>
                        </div>
                    </div>


                    <%  }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    %>

                    <!-- Final do Carrousel -->
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Feature Property Section End -->

<!-- Team Section Begin -->
<section class="team-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-8">
                <div class="section-title">
                    <h4>Corretores Destaques</h4>
                </div>
            </div>
            <div class="col-lg-4 col-md-4">
                <div class="team-btn">
                    <a href="corretores.jsp"><i class="fa fa-user"></i> Ver Todos</a>
                </div>
            </div>
        </div>
        <div class="row">

            <%
                try {
                    String nome = "";
                    String telefone = "";
                    String email = "";

                    String descricao = "";
                    String twitter = "";
                    String facebook = "";

                    st = new Conexao().conectar().createStatement();
                    rs = st.executeQuery("SELECT * FROM corretores order by id desc limit 3 ");
                    while (rs.next()) {
                        nome = rs.getString(2);
                        descricao = rs.getString(8);
                        telefone = rs.getString(4);
                        email = rs.getString(5);
                        twitter = rs.getString(9);
                        facebook = rs.getString(10);
                        imagem = rs.getString(7);
                        id = rs.getString(1);
            %>
            <div class="col-md-4">
                <div class="ts-item">
                    <div class="ts-text">
                        <img src="sistema/img/profiles/<%=imagem%>" alt="">
                        <h5><%=nome%></h5>
                        <span><i class="fa fa-whatsapp mr-1"></i><%=telefone%></span>
                        <p><%=descricao%></p>
                        <div class="ts-social">
                            <a target="_blank" href="<%=facebook%>"><i class="fa fa-facebook"></i></a>
                            <a target="_blank" href="<%=twitter%>"><i class="fa fa-twitter"></i></a>
                            <a target="_blank" title="<%=email%>" href="<%=email%>"><i class="fa fa-envelope-o"></i></a>
                            <a target="_blank" title="<%=telefone%>" href="http://api.whatsapp.com/send?1=pt_BR&phone=55<%=telefone%>&text=<%=textowhats%>"><i class="fa fa-whatsapp"></i></a>
                        </div>
                    </div>
                </div>
            </div>


            <%  }
                } catch (Exception e) {
                    out.print(e);
                }
            %>


        </div>
    </div>
</section>
<!-- Team Section End -->

<!-- Categories Section Begin -->
<section class="categories-section">
    <div class="cs-item-list">
        <%
            st = new Conexao().conectar().createStatement();
            String nomeTipo3 = "";
            String idTipo3 = "";
            String quantImoveis = "";
            String imagemTipo = "";
            rs = st.executeQuery("SELECT * FROM tipos order by imoveis desc limit 5 ");
            while (rs.next()) {

                nomeTipo3 = rs.getString(2);
                idTipo3 = rs.getString(1);
                quantImoveis = rs.getString(4);
                imagemTipo = rs.getString(3);
            
        %>
        
        <a class='linkul' href='lista-imoveis.jsp?tipo-imovel=<%=idTipo3%>'>
        <div class="cs-item set-bg" data-setbg="sistema/img/imoveis/<%=imagemTipo%>">
            <div class="cs-text">
                <h5><%=nomeTipo3%></h5>
                <span><%=quantImoveis%> im�veis</span>
            </div>
        </div>
        </a>


        <%  }   %>

    </div>
</section>
<!-- Categories Section End -->

<!-- Testimonial Section Begin -->
<section class="testimonial-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h4>Alguns de nossos Clientes</h4>
                </div>
            </div>
        </div>
        <div class="row testimonial-slider owl-carousel">
            <div class="col-lg-6">
                <div class="testimonial-item">
                    <div class="ti-text">
                        <p>Lorem ipsum dolor amet, consectetur adipiscing elit, seiusmod tempor incididunt ut labore
                            magna aliqua. Quis ipsum suspendisse ultrices gravida accumsan lacus vel facilisis.</p>
                    </div>
                    <div class="ti-author">
                        <div class="ta-pic">
                            <img src="img/testimonial-author/ta-1.jpg" alt="">
                        </div>
                        <div class="ta-text">
                            <h5>Arise Naieh</h5>
                            <span>Designer</span>
                            <div class="ta-rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="testimonial-item">
                    <div class="ti-text">
                        <p>Lorem ipsum dolor amet, consectetur adipiscing elit, seiusmod tempor incididunt ut labore
                            magna aliqua. Quis ipsum suspendisse ultrices gravida accumsan lacus vel facilisis.</p>
                    </div>
                    <div class="ti-author">
                        <div class="ta-pic">
                            <img src="img/testimonial-author/ta-2.jpg" alt="">
                        </div>
                        <div class="ta-text">
                            <h5>Arise Naieh</h5>
                            <span>Designer</span>
                            <div class="ta-rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="testimonial-item">
                    <div class="ti-text">
                        <p>Lorem ipsum dolor amet, consectetur adipiscing elit, seiusmod tempor incididunt ut labore
                            magna aliqua. Quis ipsum suspendisse ultrices gravida accumsan lacus vel facilisis.</p>
                    </div>
                    <div class="ti-author">
                        <div class="ta-pic">
                            <img src="img/testimonial-author/ta-1.jpg" alt="">
                        </div>
                        <div class="ta-text">
                            <h5>Arise Naieh</h5>
                            <span>Designer</span>
                            <div class="ta-rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Testimonial Section End -->




<jsp:include page="rodape.jsp" />    




<!-- Modal Mensagem Imovel-->
<div class="modal fade" data-backdrop="static" id="modalMensagemImovel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Enviar Mensagem</h5>
                <button id="btn-cancelar-dismiss" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="#" class="cc-form">
                    <div class="group-input">
                        <input type="text" placeholder="Nome">
                        <input id="telefone" type="text" placeholder="Telefone">
                        <input type="email" placeholder="Email">

                    </div>
                    <textarea placeholder="Coment�rio"></textarea>
                    <div align="right">
                        <button id="btn-enviar" type="submit" class="site-btn">Enviar</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>




<!-- Script para mostrar div do slider aluguel/compra -->
<script type="text/javascript">
    $(document).ready(function () {
        $('#priceAluguel').hide();
        $('#priceCompra').show();
        document.getElementById('status-form').value = "Venda";

        $('#cb-rent').click(function (event) {
            $('#priceAluguel').hide();
            $('#priceCompra').show();
            document.getElementById('status-form').value = "Venda";
        })

        $('#cb-sale').click(function (event) {
            $('#priceAluguel').show();
            $('#priceCompra').hide();
            document.getElementById('status-form').value = "Aluguel";
        })

    })
</script>



<!-- Listar todos os imoveis apos abrir modal -->
<script type="text/javascript">


    $('#btn-cancelar-dismiss').click(function (event) {
        $('#listarTodos').click();
    })


    $('#btn-enviar').click(function (event) {
        $('#listarTodos').click();
    })



</script>




<!--AJAX PARA LISTAR OS DADOS DO BAIRRO NO SELECT -->
<script type="text/javascript">
    $(document).ready(function () {
        document.getElementById('txtcidade').value = document.getElementById('cidade').value;
        listarBairros();

    })
</script>

<script type="text/javascript">
    function listarBairros() {

        $.ajax({
            url: "listar-bairros.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {

                $('#listar-bairros').html(result);
            }
        })
    }
</script>


<!-- Script para buscar pelo select -->
<script type="text/javascript">

    $('#cidade').change(function () {
        document.getElementById('txtcidade').value = $(this).val();
        listarBairros();
    })

</script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="js/mascara.js"></script>
