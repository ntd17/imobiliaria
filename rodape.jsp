i<%@page import="util.Config"%>
<%
    
    String email = new Config().email;
    String whatsapp = new Config().whatsapp;
    String telfixo = new Config().telfixo;
    String whatsappLink = new Config().whatsappLink;
%>


<!-- Footer Section Begin -->
    <footer class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="fs-about">
                        <div class="fs-logo">
                            <a href="#">
                                <img src="https://imoveismegha.com.br/assets/img/logo-rodape.png" alt="">
                            </a>
                        </div>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            labore et dolore magna aliqua ut aliquip ex ea</p>
                        <div class="fs-social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-pinterest-p"></i></a>
                            <a target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=<%=whatsappLink %>"> <i class="fa fa-whatsapp"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-sm-6">
                    
                </div>
                <div class="col-lg-2 col-sm-6">
                    <div class="fs-widget">
                        <h5>Links</h5>
                        <ul>
                            <li><a href="#">Contatos</a></li>
                            <li><a href="#">Im�veis</a></li>
                            <li><a href="#">Corretores</a></li>
                            <li><a href="#">Sobre</a></li>
                            <li><a href="#">Home</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="fs-widget">
                        <h5>Buscar Im�vel</h5>
                        <p>Digite o ID do Im�vel</p>
                        <form action="imovel-detalhes.jsp" method="get" id="busca-cod" class="subscribe-form">
                            <input type="text" name="id" placeholder="Id ou Código" fdprocessedid="lwuhu">
                            <button type="submit" class="site-btn" fdprocessedid="y6xx0b">Buscar</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="copyright-text">
                <p></p>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.richtext.min.js"></script>
    <script src="js/image-uploader.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>