<!DOCTYPE html>
<%@page import="util.Config"%> 
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    String email = new Config().email;
    String whatsapp = new Config().whatsapp;
    String telfixo = new Config().telfixo;
    String whatsappLink = new Config().whatsappLink;
%>


<html lang="zxx">

    <head>
        <meta name="url" content="https://imoveismegha.com.br/" />
        <meta name="robots" content="all" />
        <meta name="googlebot" content="all" />
        <meta name="expires" content="never" />
        <meta name="rating" content="general" />
        <meta name="description" content="Megha Imóveis - Vendas, Aluguéis, Temporadas e Empreendimentos em Santa Cruz do Sul - Apartamentos, Terrenos, Casas. Imobiliára em Santa Cruz do Sul. Imóveis em Santa Cruz do Sul." />
        <meta name="keywords" content="santa cruz do sul, imobiliaria, imoveis, apartamentos, terrenos, casa, empreendimentos, megha imoveis, aluguel de imóveis, temporada, imobiliára santa cruz do sul, imobiliaria santa cruz do sul, aluguéis de imoveis, aluguel santa cruz do sul, temporada santa cruz do sul" />
        <link rel="canonical" href="https://imoveismegha.com.br/" />
        <link rel="shortcut icon" type="image/x-icon" href="https://imoveismegha.com.br/favicon.ico">
        <title>Megha Imóveis - Vendas, Aluguéis, Temporadas e Empreendimentos em Santa Cruz do Sul - 51 3711-1600</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700,800,900&display=swap"
              rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">


        <link rel="shortcut icon" href="img/favicon0.ico" type="image/x-icon">
        <link rel="icon" href="img/favicon0.ico" type="image/x-icon">



    </head>

    <body>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Offcanvas Menu Wrapper Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="canvas-close">
                <span class="icon_close"></span>
            </div>
            <div class="logo">
                <a href="./index.jsp">
                    <img src="img/logo.png" alt="">
                </a>
            </div>
            <div id="mobile-menu-wrap"></div>
            <div class="om-widget">
                <ul>
                    <li><i class="icon_mail_alt"></i> <a href="mailto:<%=email%>"><%=email%></a></li>
                    <li><a class="text-dark" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=<%=whatsappLink%>"><i class="fa fa-whatsapp"></i> <%=whatsapp%> </a> <span><%=telfixo%></span></li>
                </ul>
               <div class="col-lg-2">
                             <form action="imovel-detalhes.jsp" method="get">

                                    <div class="group-input">
                                        <input class="cb-item" type="search" id="busca" name="id" placeholder="Id do Imóvel">
                                        <button class="btn btn-success" type="submit"><i class="fa fa-search"></i></button>
                                    </div>

                                </form>
                        </div>

            </div>
            <div class="om-social">
                <a href="#"><i class="fa fa-facebook"></i></a>
                <a href="#"><i class="fa fa-twitter"></i></a>
                <a href="#"><i class="fa fa-youtube-play"></i></a>
                <a href="#"><i class="fa fa-instagram"></i></a>
                <a href="#"><i class="fa fa-pinterest-p"></i></a>
            </div>
        </div>
        <!-- Offcanvas Menu Wrapper End -->

        <!-- Header Section Begin -->
        <header class="header-section">
            <span class="btn-logar"><a href="sistema" target="_blank" class="text-secondary"><i class="fa fa-unlock d-none d-md-block"></a></i></span>
            <span class="btn-logar-mobile"><a href="sistema" target="_blank" class="text-secondary"><i class="fa fa-unlock d-block d-sm-none"></a></i></span>
            <div class="hs-top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-2">
                            <div class="logo">
                                <a href="./index.jsp"><img src="img/logo.png" alt=""></a>
                            </div>
                        </div>
                        <div class="col-lg-8">
                            <div class="ht-widget">
                                <ul>
                                    <li><i class="icon_mail_alt"></i> <%=email%></li>
                                    <li><a class="text-dark" target="_blank" href="http://api.whatsapp.com/send?1=pt_BR&phone=<%=whatsappLink%>"><i class="fa fa-whatsapp"></i> <%=whatsapp%> </a> <span><%=telfixo%></span></li>
                                </ul>

                               

                            </div>
                        </div>
                    </div>
                    <div class="canvas-open">
                        <span class="icon_menu"></span>
                    </div>
                </div>
            </div>
            <div class="hs-nav">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9">
                            <nav class="nav-menu">
                                <ul>
                                    <li class="active"><a href="./index.jsp">Home</a></li>
                                    <li><a href="imoveis.jsp">Imóveis</a></li>
                                    <li><a href="corretores.jsp">Corretores</a></li>
                                    <li><a href="sobre.jsp">Sobre</a></li>

                                    <li><a href="contatos.jsp">Contatos</a></li>
                                </ul>
                            </nav>
                        </div>
                        <div class="col-lg-3">
                            <div class="hn-social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa fa-pinterest-p"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Header End -->