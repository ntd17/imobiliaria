<jsp:include page="cabecalho.jsp" />
<%@page import="util.Config"%> 
<%
    
    String email = new Config().email;
    String whatsapp = new Config().whatsapp;
    String telfixo = new Config().telfixo;
    String whatsappLink = new Config().whatsappLink;
%>



<!-- Contact Form Section Begin -->
<section class="contact-form-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="cf-content">
                    <div class="cc-title">
                        <h4>Contate-nos</h4>
                        <p>Preencha os campos abaixo para entrar em contato conosco, iremos responder em breve, <br>
                            se preferir pode entrar também em contato via whatsapp <a class="text-dark" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=<%=whatsappLink%>"><i class="fa fa-whatsapp mr-1"></i> <%=whatsapp%> </a></p>
                    </div>
                    <form method="post" class="cc-form mb-2">
                        <div class="group-input">
                                <input type="text" name="txtNome" placeholder="Nome">
                                <input id="telefone" name="txtTelefone" type="text" placeholder="Telefone">
                                <input type="email" name="txtEmail" placeholder="Email">
                                
                                <input type="hidden" value="<%=email%>" name="emailCorretor">

                        </div>
                         <textarea name="txtMensagem" placeholder="Comentário"></textarea>
                        <button id="btn-enviar" type="submit" class="site-btn">Enviar</button>
                    </form>
                   <small><div id="mensagem-email" align="center">   
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Contact Form Section End -->

<!-- Contact Section Begin -->
<section class="contact-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="contact-info">
                    <div class="ci-item">
                        <div class="ci-icon">
                            <i class="fa fa-map-marker"></i>
                        </div>
                        <div class="ci-text">
                            <h5>Endereço</h5>
                            <p>160 Pennsylvania Ave NW, Washington, Castle, PA 16101-5161</p>
                        </div>
                    </div>
                    <div class="ci-item">
                        <div class="ci-icon">
                            <i class="fa fa-mobile"></i>
                        </div>
                        <div class="ci-text">
                            <h5>Telefones</h5>
                            <ul>
                                <li><a class="text-dark" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=<%=whatsappLink %>"><i class="fa fa-whatsapp"></i> <%=whatsapp %> </a> </li>
                                <li><%=telfixo %></li>
                            </ul>
                        </div>
                    </div>
                    <div class="ci-item">
                        <div class="ci-icon">
                            <i class="fa fa-headphones"></i>
                        </div>
                        <div class="ci-text">
                            <h5>Email</h5>
                            <p><%=email %></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="cs-map">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15004.453961620837!2d-43.94841387071271!3d-19.919621785751325!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xa699e4e119a387%3A0xd00dc0b14abf3fc4!2sCentro%2C%20Belo%20Horizonte%20-%20MG!5e0!3m2!1spt-BR!2sbr!4v1593048428551!5m2!1spt-BR!2sbr" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
    </div>
</section>
<!-- Contact Section End -->

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
