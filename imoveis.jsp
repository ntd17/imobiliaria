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

    double num_paginas = 0;
    String pag = "";
    int itens_por_pagina = 3;
    int limite = 0;
    int pagina = 0;

    // pegar a pagina atual
    if(request.getParameter("pagina") != null){
        pag = request.getParameter("pagina");
    }else{
        pag = "0";
    }
    
    limite = Integer.parseInt(pag) * itens_por_pagina;
    pagina = Integer.parseInt(pag);
    out.print(pagina);
%>

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
                        <label for="cb-rent" class="active">
                            Compra
                            <input type="radio" id="cb-rent">
                        </label>
                    </div>
                    <div class="cb-item">
                        <label for="cb-sale">
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
<section class="property-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h4>IM�VEIS RECENTES</h4>
                </div>
            </div>
        </div>
        <div class="row">

            <!-- In�cio dos cards -->

            <%                        try {
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

                    String textowhats = "Ol�, vi seu contato no site IMOB e gostaria de mais informa��es!!";

                    st = new Conexao().conectar().createStatement();
                    st2 = new Conexao().conectar().createStatement();
                    st3 = new Conexao().conectar().createStatement();

                    rs = st.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel' order by id desc LIMIT " + limite + ", " + itens_por_pagina + " ");
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

                            //BUSCAR TODOS OS CURSOS PARA SABER O TOTAL DE CURSOS PARA DIVIDIR EM P�GINAS
                            st4 = new Conexao().conectar().createStatement();
                            rs4 = st4.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel'");
                            while (rs4.next()) {

                                i = i + 1;
                            }
                        } catch (Exception e) {
                            out.print(e);
                        }

                        num_paginas = (double) i / itens_por_pagina;
                        num_paginas = Math.ceil(num_paginas);


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


            <div class="col-lg-12">
                

                    <div class="row paginacao mt-4 justify-content-center">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="btn btn-outline-dark btn-sm mr-1" href="imoveis.jsp?pagina=0" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                                <%
                                    
                                   
                                    for (int i = 0; i < num_paginas; i++) {
                                         String estilo = "";
                                         if (pagina == i) {
                                                estilo = "active";
                                           }
                                        if (pagina >= (i - 2) && pagina <= (i + 2)) {
                                            
                                            
                                %>
                                <li class="page-item"><a class="btn btn-outline-dark btn-sm mr-1 <%=estilo %>" href="imoveis.jsp?pagina=<%=i%>"><%=i+1%></a></li>
                                    <% }
                                        }%>

                                <li class="page-item">
                                    <a class="btn btn-outline-dark btn-sm " href="imoveis.jsp?pagina=<%=Math.round(num_paginas-1) %>" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>

                    </div> 

                
            </div>
        </div>
    </div>
</section>
<!-- Property Section End -->

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
    function listarBairros(){
       
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