<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 

<%
    Statement st = null;
    ResultSet rs = null;

    String cidade = request.getParameter("txtcidade");

%>


<%    out.print("<select class='sm-width form-control' name='bairro' id='bairro'>");

    st = new Conexao().conectar().createStatement();
    rs = st.executeQuery("SELECT * FROM bairros where cidade = '" + cidade + "' order by nome asc");

    while (rs.next()) {
       
     out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
        
    }

    out.print("</select>");%>


