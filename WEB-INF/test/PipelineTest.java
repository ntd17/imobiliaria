package test;

import java.net.HttpURLConnection;
import java.net.URL;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.time.Duration;
import java.util.List;
public class PipelineTest {

    private static final Logger logger = LogManager.getLogger(PipelineTest.class);
    private WebDriver driver;
    private WebDriverWait wait;

    @BeforeClass
    public void setUp() {
        try {
            String chromeDriverPath = "/root/actions-runner/webapps/WEB-INF/lib/chromedriver";
            String chromeBinaryPath = "/root/actions-runner/chrome-linux64/chrome";
            System.out.println("Path to chromedriver: " + chromeDriverPath);
            System.setProperty("webdriver.chrome.driver", chromeDriverPath);

            ChromeOptions options = new ChromeOptions();
            options.setBinary(chromeBinaryPath);
            options.addArguments("--headless", "--no-sandbox", "--disable-dev-shm-usage");

            driver = new ChromeDriver(options);
            wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            logger.info("ChromeDriver inicializado com sucesso.");
        } catch (Exception e) {
            logger.error("Falha ao inicializar o ChromeDriver: " + e.getMessage(), e);
            Assert.fail("Falha ao inicializar o ChromeDriver.");
        }
    }

    @Test(priority = 1)
    public void testHttpStatus() {
        try {
            driver.manage().deleteAllCookies();
            URL url = new URL("http://217.15.171.97/");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();

            int responseCode = connection.getResponseCode();
            logger.info("Código de status HTTP: " + responseCode);
            Assert.assertEquals(responseCode, 200, "A página não retornou status 200");
        } catch (Exception e) {
            logger.error("Falha ao verificar o status HTTP.", e);
            Assert.fail("Falha ao verificar o status HTTP.");
        }
    }

    @Test(priority = 2)
    public void testHttpStatusSistema() {
        try {
            driver.manage().deleteAllCookies();
            URL url = new URL("http://217.15.171.97/sistema");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();

            int responseCode = connection.getResponseCode();
            logger.info("Código de status HTTP: " + responseCode);
            Assert.assertEquals(responseCode, 200, "A página não retornou status 200");
        } catch (Exception e) {
            logger.error("Falha ao verificar o status HTTP.", e);
            Assert.fail("Falha ao verificar o status HTTP.");
        }
    }

    @Test(priority = 3)
    public void loginAdminTest() {
        try {
            driver.manage().deleteAllCookies();
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            String expectedUrl = "http://217.15.171.97/sistema/painel-admin/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "Login failed");
            logger.info("Login bem-sucedido. URL atual: " + driver.getCurrentUrl());
        } catch (Exception e) {
            logger.error("Falha durante o teste de login.", e);
            Assert.fail("Falha durante o teste de login.");
        }
    }

    @Test(priority = 4)
    public void cidadeTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login
            driver.get("http://217.15.171.97/sistema");

            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-admin/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "URL após login está incorreta.");

            // Navega manualmente para a página de cidades
            driver.get("http://217.15.171.97/sistema/painel-admin/index.jsp?pag=cidade");

            // Verifique a presença do botão "Nova Cidade"
            WebElement novaCidadeButton = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("nova-cidade-btn")));
            novaCidadeButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("nova-cidade-btn")));
            Assert.assertTrue(novaCidadeButton.isDisplayed(), "Botão 'Nova Cidade' não está visível.");
            Assert.assertTrue(novaCidadeButton.isEnabled(), "Botão 'Nova Cidade' não está habilitado.");
            logger.info("Botão 'Nova Cidade' encontrado e visível.");
            novaCidadeButton.click();

            // Espera pelo modal e encontra os elementos novamente para evitar StaleElementReferenceException
            WebElement nomeField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("nome")));
            nomeField = wait.until(ExpectedConditions.elementToBeClickable(By.name("nome")));
            Assert.assertTrue(nomeField.isDisplayed(), "Campo de nome não está visível.");
            Assert.assertTrue(nomeField.isEnabled(), "Campo de nome não está habilitado.");
            nomeField.sendKeys("Cidade Teste");

            WebElement salvarButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-salvar")));
            salvarButton.click();

            // Recarrega a página para garantir que as atualizações sejam aplicadas
            driver.navigate().refresh();

            // Verifique se a cidade foi criada com sucesso ao recarregar a página
            WebElement cidadeCriada = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Cidade Teste')]")));
            Assert.assertNotNull(cidadeCriada, "A cidade 'Cidade Teste' não foi encontrada na lista.");
            logger.info("Nova cidade 'Cidade Teste' criada com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de cidade.", e);
            Assert.fail("Falha durante o teste de cidade.");
        }
    }

    @Test(priority = 5)
    public void deleteCidadeTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login
            driver.get("http://217.15.171.97/sistema");

            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-admin/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "URL após login está incorreta.");

            // Navega manualmente para a página de cidades
            driver.get("http://217.15.171.97/sistema/painel-admin/index.jsp?pag=cidade");

            // Verifique se a cidade 'Cidade Teste' está presente na lista
            WebElement cidadeCriada = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Cidade Teste')]")));
            Assert.assertNotNull(cidadeCriada, "A cidade 'Cidade Teste' não foi encontrada na lista.");

            // Localiza o botão de exclusão da cidade 'Cidade Teste'
            WebElement deleteButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//td[contains(text(), 'Cidade Teste')]/following-sibling::td/a[contains(@href, 'funcao=excluir')]")));
            deleteButton.click();

            // Confirma a exclusão no modal
            WebElement confirmDeleteButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-deletar")));
            confirmDeleteButton.click();

            // Recarrega a página para garantir que as atualizações sejam aplicadas
            driver.navigate().refresh();

            // Verifique se a cidade foi excluída com sucesso ao recarregar a página
            boolean isCidadeExcluida = driver.findElements(By.xpath("//td[contains(text(), 'Cidade Teste')]")).isEmpty();
            Assert.assertTrue(isCidadeExcluida, "A cidade 'Cidade Teste' ainda está presente na lista.");

            logger.info("Cidade 'Cidade Teste' excluída com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de exclusão de cidade.", e);
            Assert.fail("Falha durante o teste de exclusão de cidade.");
        }
    }

    @Test(priority = 6)
    public void bairroTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login
            driver.get("http://217.15.171.97/sistema");

            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-admin/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "URL após login está incorreta.");

            // Navega manualmente para a página de cidades
            driver.get("http://217.15.171.97/sistema/painel-admin/index.jsp?pag=bairro");

            // Verifique a presença do botão "Nova Cidade"
            WebElement novaCidadeButton = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("novo-bairro-btn")));
            novaCidadeButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("novo-bairro-btn")));
            Assert.assertTrue(novaCidadeButton.isDisplayed(), "Botão 'Novo Bairro' não está visível.");
            Assert.assertTrue(novaCidadeButton.isEnabled(), "Botão 'Novo Bairro' não está habilitado.");
            logger.info("Botão 'Nova Cidade' encontrado e visível.");
            novaCidadeButton.click();

            // Espera pelo modal e encontra os elementos novamente para evitar StaleElementReferenceException
            WebElement nomeField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("nome")));
            nomeField = wait.until(ExpectedConditions.elementToBeClickable(By.name("nome")));
            Assert.assertTrue(nomeField.isDisplayed(), "Campo de nome não está visível.");
            Assert.assertTrue(nomeField.isEnabled(), "Campo de nome não está habilitado.");
            nomeField.sendKeys("Bairro Teste");

            WebElement salvarButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-salvar")));
            salvarButton.click();

            // Recarrega a página para garantir que as atualizações sejam aplicadas
            driver.navigate().refresh();

            // Verifique se a cidade foi criada com sucesso ao recarregar a página
            WebElement cidadeCriada = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Bairro Teste')]")));
            Assert.assertNotNull(cidadeCriada, "O Bairro 'Bairro Teste' não foi encontrado na lista.");
            logger.info("Novo bairro 'Bairro Teste' criado com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de bairro.", e);
            Assert.fail("Falha durante o teste de bairro.");
        }
    }

    @Test(priority = 7)
    public void deleteBairroTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login
            driver.get("http://217.15.171.97/sistema");

            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-admin/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "URL após login está incorreta.");

            // Navega manualmente para a página de cidades
            driver.get("http://217.15.171.97/sistema/painel-admin/index.jsp?pag=bairro");

            // Verifique se a cidade 'Cidade Teste' está presente na lista
            WebElement cidadeCriada = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Bairro Teste')]")));
            Assert.assertNotNull(cidadeCriada, "O Bairro 'Bairro Teste' não foi encontrado na lista.");

            // Localiza o botão de exclusão da cidade 'Cidade Teste'
            WebElement deleteButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//td[contains(text(), 'Bairro Teste')]/following-sibling::td/a[contains(@href, 'funcao=excluir')]")));
            deleteButton.click();

            // Confirma a exclusão no modal
            WebElement confirmDeleteButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-deletar")));
            confirmDeleteButton.click();

            // Recarrega a página para garantir que as atualizações sejam aplicadas
            driver.navigate().refresh();

            // Verifique se a cidade foi excluída com sucesso ao recarregar a página
            boolean isCidadeExcluida = driver.findElements(By.xpath("//td[contains(text(), 'Bairro Teste')]")).isEmpty();
            Assert.assertTrue(isCidadeExcluida, "O Bairro 'Bairro Teste' ainda está presente na lista.");

            logger.info("Bairro 'Bairro Teste' excluída com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de exclusão de bairro.", e);
            Assert.fail("Falha durante o teste de exclusão de bairro.");
        }
    }

    @Test(priority = 8)
    public void loginCorretorTest() {
        try {
            driver.manage().deleteAllCookies();
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("corretor@admin.com");
            password.sendKeys("123");
            loginButton.click();

            String expectedUrl = "http://217.15.171.97/sistema/painel-corretor/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "Login failed");
            logger.info("Login bem-sucedido. URL atual: " + driver.getCurrentUrl());
        } catch (Exception e) {
            logger.error("Falha durante o teste de login.", e);
            Assert.fail("Falha durante o teste de login.");
        }
    }

    @Test(priority = 9)
    public void loginTesouroTest() {
        try {
            driver.manage().deleteAllCookies();
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("tesouro@admin.com");
            password.sendKeys("123");
            loginButton.click();

            String expectedUrl = "http://217.15.171.97/sistema/painel-tesouraria/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "Login failed");
            logger.info("Login bem-sucedido. URL atual: " + driver.getCurrentUrl());
        } catch (Exception e) {
            logger.error("Falha durante o teste de login.", e);
            Assert.fail("Falha durante o teste de login.");
        }
    }

    @Test(priority = 10)
    public void listarVendedoresTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login como corretor
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("corretor@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-corretor/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "Login failed");
            logger.info("Login como corretor bem-sucedido. URL atual: " + driver.getCurrentUrl());

            // Navega para a página de vendedores
            driver.get("http://217.15.171.97/sistema/painel-corretor/index.jsp?pag=vendedores");

            // Verifica se a lista de vendedores está presente
            WebElement tabelaVendedores = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("dataTable")));
            Assert.assertTrue(tabelaVendedores.isDisplayed(), "Tabela de vendedores não está visível.");
            logger.info("Lista de vendedores carregada com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de listagem de vendedores como corretor.", e);
            Assert.fail("Falha durante o teste de listagem de vendedores como corretor.");
        }
    }

    @Test(priority = 11)
    public void listarCorretoresTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login como corretor
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("corretor@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-corretor/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "Login failed");
            logger.info("Login como corretor bem-sucedido. URL atual: " + driver.getCurrentUrl());

            // Navega para a página de vendedores
            driver.get("http://217.15.171.97/sistema/painel-corretor/index.jsp?pag=vendedores");

            // Verifica se a lista de vendedores está presente
            WebElement tabelaVendedores = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("dataTable")));
            Assert.assertTrue(tabelaVendedores.isDisplayed(), "Tabela de vendedores não está visível.");
            logger.info("Lista de vendedores carregada com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de listagem de vendedores como corretor.", e);
            Assert.fail("Falha durante o teste de listagem de vendedores como corretor.");
        }
    }

    @Test(priority = 12)
    public void editarTituloImovelTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login como corretor
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("corretor@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Verifique se a URL está correta após o login
            String expectedUrl = "http://217.15.171.97/sistema/painel-corretor/";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "Login failed");
            logger.info("Login como corretor bem-sucedido. URL atual: " + driver.getCurrentUrl());

            // Navega para a página de edição do imóvel
            driver.get("http://217.15.171.97/sistema/painel-corretor/index.jsp?pag=imoveis&funcao=editar&id=170");

            // Espera pelo modal de edição aparecer e edita o título do imóvel
            WebElement tituloField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("titulo")));
            tituloField.clear();
            tituloField.sendKeys("Apartamento 3 Quartos");

            // Clica no botão de salvar
            WebElement salvarButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-salvar")));
            salvarButton.click();

            // Recarrega a página para garantir que as atualizações sejam aplicadas
            driver.navigate().refresh();

            // Verifica se o título foi editado com sucesso ao recarregar a página
            WebElement tituloEditado = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Apartamento 3 Quartos')]")));
            Assert.assertNotNull(tituloEditado, "O título do imóvel não foi editado corretamente.");
            logger.info("Título do imóvel editado com sucesso para 'Apartamento 3 Quartos'.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de edição do título do imóvel.", e);
            Assert.fail("Falha durante o teste de edição do título do imóvel.");
        }
    }

    @Test(priority = 13)
    public void buscarImovelTest() {
        try {
            driver.get("http://217.15.171.97/");

            // Adiciona uma pequena espera para garantir que a página tenha carregado completamente
            Thread.sleep(2000);

            WebElement form = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("busca-cod")));

            WebElement idInput = form.findElement(By.name("id"));
            idInput.click(); // Garante que o campo de entrada esteja focado
            idInput.clear(); // Limpa o campo de entrada
            idInput.sendKeys("32"); // Envia o valor "32" para o campo de entrada

            WebElement buscarButton = form.findElement(By.cssSelector("button.site-btn"));
            buscarButton.click();

            String expectedUrl = "http://217.15.171.97/imovel-detalhes.jsp?id=32";
            wait.until(ExpectedConditions.urlToBe(expectedUrl));
            Assert.assertEquals(driver.getCurrentUrl(), expectedUrl, "A página não redirecionou corretamente.");
            logger.info("Busca de imóvel bem-sucedida. URL atual: " + driver.getCurrentUrl());
        } catch (Exception e) {
            logger.error("Falha durante o teste de busca de imóvel.", e);
            Assert.fail("Falha durante o teste de busca de imóvel.");
        }
    }

    @Test(priority = 14)
    public void testPaginacaoImoveis() {
        try {
            // Navega até a página inicial de imóveis
            driver.get("http://217.15.171.97/imoveis.jsp");

            // Espera até que o botão de página 2 esteja presente e clicável
            WebElement pagina2Button = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[text()='2']")));
            pagina2Button.click();
            logger.info("Navegou para a página 2.");

            // Espera até que o botão de página 3 esteja presente e clicável
            WebElement pagina3Button = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[text()='3']")));
            pagina3Button.click();
            logger.info("Navegou para a página 3.");

            // Espera até que o botão de página 1 esteja presente e clicável
            WebElement pagina1Button = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[text()='1']")));
            pagina1Button.click();
            logger.info("Navegou de volta para a página 1.");

            Assert.assertTrue(driver.getCurrentUrl().contains("imoveis.jsp"), "A navegação de paginação falhou.");
            logger.info("Teste de paginação concluído com sucesso.");
        } catch (Exception e) {
            logger.error("Falha durante o teste de paginação.", e);
            Assert.fail("Falha durante o teste de paginação.");
        }
    }

    @Test(priority = 15)
    public void listarVendasTest() {
        try {
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Navega para a página de vendas
            driver.get("http://217.15.171.97/sistema/painel-admin/index.jsp?pag=vendas");

            // Verifica se a lista de vendas está presente
            WebElement tabelaVendas = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("dataTable")));
            Assert.assertTrue(tabelaVendas.isDisplayed(), "Tabela de vendas não está visível.");
            logger.info("Lista de vendas carregada com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de listagem de vendas.", e);
            Assert.fail("Falha durante o teste de listagem de vendas.");
        }
    }


    @Test(priority = 16)
    public void navegarCorretoresTest() {
        try {
            driver.get("http://217.15.171.97/corretores.jsp");

            // Espera pela página carregar completamente
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("as-slider")));

            // Identifica os botões de paginação e clica em cada um deles
            List<WebElement> paginacao = driver.findElements(By.className("page-link"));
            for (WebElement pagina : paginacao) {
                pagina.click();
                // Espera pela página carregar
                Thread.sleep(2000); // Adiciona uma pausa para garantir que a página carrega completamente

                // Verifica se a página atual está destacada
                WebElement activePage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".pagination .active")));
                System.out.println("Navegando para a página: " + activePage.getText());

                // Adiciona uma verificação simples para garantir que os corretores estão carregando
                List<WebElement> corretores = driver.findElements(By.className("as-item"));
                Assert.assertTrue(corretores.size() > 0, "Nenhum corretor encontrado na página " + activePage.getText());
            }

            logger.info("Navegação de corretores realizada com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante a navegação de corretores.", e);
            Assert.fail("Falha durante a navegação de corretores.");
        }
    }

    @Test(priority = 17)
    public void verificarLinkMailtoTest() {
        try {
            driver.get("http://217.15.171.97/contatos.jsp");

            // Localiza o link mailto pelo ícone de email ou pelo email específico
            WebElement mailtoLink = wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("a[href^='mailto:']")));

            // Verifica se o link está correto
            String href = mailtoLink.getAttribute("href");
            Assert.assertTrue(href.contains("mailto:"), "O link 'mailto' não está presente.");
            Assert.assertTrue(href.contains("megha@imoveismegha.com.br"), "O link 'mailto' não contém o email esperado.");

            logger.info("Link 'mailto' verificado com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante a verificação do link 'mailto'.", e);
            Assert.fail("Falha durante a verificação do link 'mailto'.");
        }
    }

    @Test(priority = 18)
    public void listarTarefasTest() {
        try {
            driver.manage().deleteAllCookies();
            // Realiza o login como corretor
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("corretor@admin.com");
            password.sendKeys("123");
            loginButton.click();


            // Navega para a página de tarefas
            driver.get("http://217.15.171.97/sistema/painel-corretor/index.jsp?pag=tarefas");

            // Verifica a presença da tabela de tarefas
            WebElement tabelaTarefas = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("dataTable")));
            Assert.assertTrue(tabelaTarefas.isDisplayed(), "Tabela de tarefas não está visível.");
            logger.info("Tabela de tarefas encontrada e visível.");
        } catch (Exception e) {
            logger.error("Falha durante o teste de listagem de tarefas.", e);
            Assert.fail("Falha durante o teste de listagem de tarefas.");
        }
    }

    @Test(priority = 19)
    public void inserirTarefaTest() {
        try {
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("corretor@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Navega para a página de tarefas
            driver.get("http://217.15.171.97/sistema/painel-corretor/index.jsp?pag=tarefas");

            // Clica no botão de nova tarefa
            WebElement novaTarefaButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[contains(text(), 'Nova Tarefa')]")));
            novaTarefaButton.click();

            // Preenche o formulário de nova tarefa
            WebElement tituloField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("titulo")));
            WebElement descricaoField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("descricao")));
            WebElement dataField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("data")));
            WebElement horaField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("hora")));
            WebElement imovelField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("imovel")));
            WebElement salvarButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-salvar")));

            tituloField.sendKeys("Tarefa Teste");
            descricaoField.sendKeys("Descrição da Tarefa Teste");
            dataField.sendKeys("2024-07-22");
            horaField.sendKeys("10:00");
            imovelField.sendKeys("136");
            salvarButton.click();

            // Verifica se a nova tarefa foi criada com sucesso
            WebElement novaTarefa = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Tarefa Teste')]")));
            Assert.assertNotNull(novaTarefa, "A nova tarefa 'Tarefa Teste' não foi encontrada na lista.");
            logger.info("Nova tarefa 'Tarefa Teste' criada com sucesso.");
        } catch (Exception e) {
            logger.error("Falha durante o teste de inserção de tarefa.", e);
            Assert.fail("Falha durante o teste de inserção de tarefa.");
        }
    }

    @Test(priority = 20)
    public void listarAlugueisTest() {
        try {
            driver.get("http://217.15.171.97/sistema");
            WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("email")));
            WebElement password = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("senha")));
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@type='submit' and @value='Logar']")));

            username.sendKeys("admin@admin.com");
            password.sendKeys("123");
            loginButton.click();

            // Navega para a página de aluguéis
            driver.get("http://217.15.171.97/sistema/painel-admin/index.jsp?pag=alugueis");

            // Verifica se a lista de aluguéis está presente
            WebElement tabelaAlugueis = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("dataTable")));
            Assert.assertTrue(tabelaAlugueis.isDisplayed(), "Tabela de aluguéis não está visível.");
            logger.info("Lista de aluguéis carregada com sucesso.");

        } catch (Exception e) {
            logger.error("Falha durante o teste de listagem de aluguéis.", e);
            Assert.fail("Falha durante o teste de listagem de aluguéis.");
        }
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}