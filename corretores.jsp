<jsp:include page="cabecalho.jsp" />

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.*"%> 


<%
    Statement st = null;
    ResultSet rs = null;

%>


<!-- Agent Section Begin -->
<section class="agent-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="agent-search-form">
                    <form action="corretores.jsp">
                        <input type="text" name="nome" placeholder="Buscar Corretor">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>
            </div>
        </div>
        <div class="as-slider owl-carousel">
            <div class="row">

                <!-- Início do Card Corretores -->

                <%                        try {
                        String nome = "";
                        String telefone = "";
                        String email = "";
                        String imagem = "";
                        String id = "";
                        String descricao = "";
                        String twitter = "";
                        String facebook = "";
                        
                        String busca = "";
                        if(request.getParameter("nome") != null){
                            busca = request.getParameter("nome");
                        }

                        String textowhats = "Olá, vi seu contato no site IMOB e gostaria de mais informações!!";

                        st = new Conexao().conectar().createStatement();
                        rs = st.executeQuery("SELECT * FROM corretores where nome LIKE '%"+busca+"%'");
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

                <div class="col-lg-4 col-md-6">
                    <div class="as-item">
                        <div class="as-pic">
                            <img src="sistema/img/profiles/<%=imagem%>" alt="">
                            <div class="rating-point">
                                5
                            </div>
                        </div>
                        <div class="as-text">
                            <div class="at-title">
                                <h6><%=nome%></h6>
                                <div class="rating-star">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half-o"></i>
                                </div>
                            </div>
                            <ul>
                                <li>Imóveis <span>215</span></li>
                                <li>Email <span><%=email%></span></li>
                                <li>Whatsapp <span><i class="fa fa-whatsapp mr-1"></i><%=telefone%></span></li>
                            </ul>
                            <a class="primary-btn" title="<%=telefone%>" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=55<%=telefone%>"><i class="fa fa-whatsapp mr-1"></i>Contactar</a>
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
    </div>
</section>
<!-- Agent Section End -->


<jsp:include page="rodape.jsp" />  