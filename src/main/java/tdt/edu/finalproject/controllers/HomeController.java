package tdt.edu.finalproject.controllers;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tdt.edu.finalproject.models.Account;
import tdt.edu.finalproject.models.Cart;
import tdt.edu.finalproject.models.Flower;
import tdt.edu.finalproject.models.OrderF;
import tdt.edu.finalproject.repositories.AccountRepository;
import tdt.edu.finalproject.repositories.CartRepository;
import tdt.edu.finalproject.repositories.FlowerRepository;
import tdt.edu.finalproject.repositories.OrderRepository;
import tdt.edu.finalproject.repositories.SendEmailService;

@Controller
@RequestMapping("/")
public class HomeController {
    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private SendEmailService sendEmailService;

    @Autowired
    private FlowerRepository flowerRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private OrderRepository orderRepository;

    private HashPassword hashPassword = new HashPassword();

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String getHomePage() {
        return "/user/index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLoginPage(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            return "/user/index";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String postLoginPage(ModelMap modelMap, @RequestParam("login-username") String login_username,
            @RequestParam("login-password") String login_password, HttpSession httpSession)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        if (httpSession.getAttribute("username") == null) {
            String error = "";

            if (login_username.isEmpty()) {
                error = "Vui lòng điền username";
            } else if (login_password.isEmpty()) {
                error = "Vui lòng điền mật khẩu";
            }

            if (!error.isEmpty()) {
                modelMap.addAttribute("error", error);
                return "/user/login";
            }

            Account account = accountRepository.findAccountByUsername(login_username);
            if (account != null) {
                if (hashPassword.ValidatePassword(login_password, account.getPassword())
                        && account.getRole().equals("user")) {
                    httpSession.setAttribute("username", account.getUsername());
                    httpSession.setAttribute("role", account.getRole());
                    return "/user/index";
                }
            }

            modelMap.addAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            return "/user/login";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String postSignupPage(ModelMap modelMap, @RequestParam("signup-username") String signup_username,
            @RequestParam("signup-fullname") String signup_fullname, @RequestParam("signup-email") String signup_email,
            @RequestParam("signup-password") String signup_password,
            @RequestParam("signup-confirmPassword") String signup_confirmPassword, HttpSession httpSession)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        if (httpSession.getAttribute("username") == null) {
            String error = "";
            if (signup_username.isEmpty()) {
                error = "Vui lòng điền username";
            } else if (signup_fullname.isEmpty()) {
                error = "Vui lòng điền họ tên";
            } else if (signup_email.isEmpty()) {
                error = "Vui lòng điền email";
            } else if (signup_password.isEmpty()) {
                error = "Vui lòng nhập mật khẩu";
            } else if (signup_confirmPassword.isEmpty()) {
                error = "Vui lòng nhập lại mật khẩu";
            } else if (signup_password.length() < 6) {
                error = "Mật khẩu ít nhất 6 ký tự";
            } else if (!signup_password.equals(signup_confirmPassword)) {
                error = "Mật khẩu không trùng khớp";
            }

            Account findByUsername = accountRepository.findAccountByUsername(signup_username);
            Account findByEmail = accountRepository.findAccountByEmail(signup_email);

            if (findByUsername != null && findByUsername.getUsername().equals(signup_username)) {
                error = "Tên tài khoản đã tồn tại";
            } else if (findByEmail != null && findByEmail.getEmail().equals(signup_email)) {
                error = "Email đã tồn tại";
            }

            if (!error.isEmpty()) {
                modelMap.addAttribute("error", error);
                modelMap.addAttribute("signup_username", signup_username);
                modelMap.addAttribute("signup_fullname", signup_fullname);
                modelMap.addAttribute("signup_email", signup_email);
                return "/user/login";
            }

            String passwordHashed = hashPassword.GenerateStringPasswordHash(signup_password);
            Account createAccount = new Account(signup_username, signup_fullname, signup_email, passwordHashed, "user");
            accountRepository.save(createAccount);
            modelMap.addAttribute("message", "Tạo tài khoản thành công!");
            return "/user/login";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public String getHistoryOrder(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Iterable<OrderF> orders = orderRepository.findAllOrderByUsername(username);
            modelMap.addAttribute("orders", orders);
            return "/user/historyorder";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/flowers", method = RequestMethod.GET)
    public String getFlowerList(ModelMap modelMap) {
        Iterable<Flower> flowers = flowerRepository.findAll();
        modelMap.addAttribute("flowers", flowers);
        return "/user/flowerlist";
    }

    @RequestMapping(value = "/flowers/{category}", method = RequestMethod.GET)
    public String getFlowerListByTheme(ModelMap modelMap, @PathVariable String category) {
        if (category.equals("birthday")) {
            Iterable<Flower> flowers = flowerRepository.findByCategoryBirthday(category);
            modelMap.addAttribute("flowers", flowers);
        } else if (category.equals("congrate")) {
            Iterable<Flower> flowers = flowerRepository.findByCategoryCongrate(category);
            modelMap.addAttribute("flowers", flowers);
        } else if (category.equals("love")) {
            Iterable<Flower> flowers = flowerRepository.findByCategoryLove(category);
            modelMap.addAttribute("flowers", flowers);
        } else if (category.equals("open")) {
            Iterable<Flower> flowers = flowerRepository.findByCategoryOpen(category);
            modelMap.addAttribute("flowers", flowers);
        } else if (category.equals("wedding")) {
            Iterable<Flower> flowers = flowerRepository.findByCategoryWedding(category);
            modelMap.addAttribute("flowers", flowers);
        } else if (category.equals("foreign")) {
            Iterable<Flower> flowers = flowerRepository.findByCategoryForeign(category);
            modelMap.addAttribute("flowers", flowers);
        }
        return "/user/flowerlist";
    }

    @RequestMapping(value = "/flowers", method = RequestMethod.POST)
    public String postFlowerList(ModelMap modelMap, @RequestParam("sort-price") String sort_price,
            @RequestParam("price-from") String price_from, @RequestParam("price-to") String price_to,
            @RequestParam("sort-name") String sort_name,
            @RequestParam("byname") String name) {
        Iterable<Flower> flowers = new ArrayList<>();
        if (name.isEmpty()) {
            if (sort_price.equals("1")) { // 1: thap den cao
                flowers = flowerRepository.FilterFlowerByPriceASC();
            } else if (sort_price.equals("2")) { // 2: cao den thap
                flowers = flowerRepository.FilterFlowerByPriceDESC();
            } else if (sort_name.equals("0")) { // 0: A - Z
                flowers = flowerRepository.FilterFlowerByNameASC();
            } else if (sort_name.equals("1")) { // 1: Z - A
                flowers = flowerRepository.FilterFlowerByNameDESC();
            } else {
                flowers = flowerRepository.findAll();
            }
        } else if (!name.isEmpty()) {
            if (sort_price.equals("1")) { // 1: thap den cao
                flowers = flowerRepository.findByNameAndFilterFlowerByPriceASC(name);
            } else if (sort_price.equals("2")) { // 2: cao den thap
                flowers = flowerRepository.findByNameAndFilterFlowerByPriceDESC(name);
            } else if (sort_name.equals("0")) { // 0: A - Z
                flowers = flowerRepository.findByNameAndFilterFlowerByNameASC(name);
            } else if (sort_name.equals("1")) { // 1: Z - A
                flowers = flowerRepository.findByNameAndFilterFlowerByNameDESC(name);
            } else {
                flowers = flowerRepository.findAllFlowerByName(name);
            }
        } else {
            flowers = flowerRepository.findAll();
        }

        if (!price_from.isEmpty() && !price_to.isEmpty()) {
            int price_from_int = Integer.parseInt(price_from);
            int price_to_int = Integer.parseInt(price_to);
            List<Flower> flowersSend = new ArrayList<>();
            for (Flower flower : flowers) {
                if (flower.getPrice() >= price_from_int && flower.getPrice() <= price_to_int) {
                    flowersSend.add(flower);
                }
            }
            modelMap.addAttribute("flowers", flowersSend);
        } else {
            modelMap.addAttribute("flowers", flowers);
        }
        modelMap.addAttribute("name", name);
        modelMap.addAttribute("sort_price", sort_price);
        modelMap.addAttribute("sort_name", sort_name);
        modelMap.addAttribute("price_from", price_from);
        modelMap.addAttribute("price_to", price_to);
        return "/user/flowerlist";
    }

    @RequestMapping(value = "/flowerinfo/{id}", method = RequestMethod.GET)
    public String getFlowerInfo(@PathVariable int id, ModelMap modelMap) {
        Optional<Flower> flower = flowerRepository.findById(id);
        modelMap.addAttribute("flower", flower.get());
        return "/user/flowerinfo";
    }

    @GetMapping("/flowerinfo/detail/{id}")
    public ResponseEntity<Flower> getFlowerById(@PathVariable String id) {
        Flower flower = flowerRepository.findFlowerByIdFlower(Integer.parseInt(id));
        return new ResponseEntity<>(flower, HttpStatus.OK);
    }

    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public String getCart(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Iterable<Cart> carts = cartRepository.findCartByUsernameOrder(username);
            int quantity_flower = 0;
            int total = 0;
            for (Cart cart : carts) {
                quantity_flower += cart.getQuantityFlower();
                total += cart.getTotal();
            }
            modelMap.addAttribute("carts", carts);
            modelMap.addAttribute("totalFlower", quantity_flower);
            modelMap.addAttribute("total", total);
            return "/user/cartstep1";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart/add", method = RequestMethod.POST)
    public String postAddCart(ModelMap modelMap, @RequestParam("flower-id") int flower_id,
            @RequestParam("flower-amount") int flower_amount, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Iterable<Flower> flowers = flowerRepository.findFlowerById(flower_id);
            int total = 0;
            String name = "";
            String image = "";
            int price = 0;
            for (Flower flower : flowers) {
                total = flower.getPrice() * flower_amount;
                name = flower.getName();
                image = flower.getImage1();
                price = flower.getPrice();
            }

            Iterable<Cart> carts = cartRepository.findCartByIdFlower(flower_id);
            for (Cart cart : carts) {
                if (cart.getIdFlower() == flower_id) {
                    if (cart.getStatus().equals("Thêm vào giỏ")) {
                        flower_amount += cart.getQuantityFlower();
                        total += cart.getTotal();
                        Cart cart1 = new Cart(cart.getId(), flower_id, name, flower_amount, price, image, username,
                                "Thêm vào giỏ", total);
                        cartRepository.save(cart1);
                        Iterable<Flower> flowers1 = flowerRepository.findAll();
                        modelMap.addAttribute("message", "Thêm vào giỏ hàng thành công!");
                        modelMap.addAttribute("flowers", flowers1);
                        return "/user/flowerlist";
                    }
                }
            }

            Cart cart = new Cart(0, flower_id, name, flower_amount, price, image, username, "Thêm vào giỏ", total);
            cartRepository.save(cart);
            Iterable<Flower> flowers1 = flowerRepository.findAll();
            modelMap.addAttribute("message", "Thêm vào giỏ hàng thành công!");
            modelMap.addAttribute("flowers", flowers1);
            return "/user/flowerlist";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart/delete", method = RequestMethod.POST)
    public String postDelteCart(ModelMap modelMap, @RequestParam("id-cart") String id_cart, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            cartRepository.updateCancelCart(Integer.parseInt(id_cart));
            Iterable<Cart> carts = cartRepository.findCartByUsernameOrder(username);
            int quantity_flower = 0;
            int total = 0;
            for (Cart cart : carts) {
                quantity_flower += cart.getQuantityFlower();
                total += cart.getTotal();
            }
            modelMap.addAttribute("carts", carts);
            modelMap.addAttribute("totalFlower", quantity_flower);
            modelMap.addAttribute("total", total);
            modelMap.addAttribute("message", "Xoá sản phẩm thành công!");
            return "/user/cartstep1";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart/ordernow", method = RequestMethod.POST)
    public String postCart(ModelMap modelMap, @RequestParam("flower-id") int flower_id,
            @RequestParam("flower-amount") int flower_amount, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Iterable<Flower> flowers = flowerRepository.findFlowerById(flower_id);
            int total = 0;
            String name = "";
            String image = "";
            int price = 0;
            for (Flower flower : flowers) {
                total = flower.getPrice() * flower_amount;
                name = flower.getName();
                image = flower.getImage1();
                price = flower.getPrice();
            }
            List<Cart> carts = new ArrayList<>();
            Cart cart = new Cart(0, flower_id, name, flower_amount, price, image, username, "ordernow", total);
            carts.add(cart);

            modelMap.addAttribute("carts", carts);
            modelMap.addAttribute("totalFlower", flower_amount);
            modelMap.addAttribute("cart_status", "ordernow");
            modelMap.addAttribute("id_flower", flower_id);
            modelMap.addAttribute("name_flower", name);
            modelMap.addAttribute("total", total);
            return "/user/cartstep1";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-2", method = RequestMethod.GET)
    public String getFillInfo(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            return "/user/cartstep2";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-2", method = RequestMethod.POST)
    public String postFillInfo(ModelMap modelMap, @RequestParam("total") String total,
            @RequestParam("quantity-flower") String quantity_flower, @RequestParam("id-flower") String id_flower,
            @RequestParam("name-flower") String name_flower, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Iterable<Cart> carts = cartRepository.findCartByUsernameOrder(username);
            modelMap.addAttribute("carts", carts);
            modelMap.addAttribute("total", total);
            return "/user/cartstep2";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-2/ordernow", method = RequestMethod.POST)
    public String postCartStep2Ordernow(ModelMap modelMap, @RequestParam("quantity-flower") String quantity_flower,
            @RequestParam("cart-status") String cart_status, @RequestParam("id-flower") int id_flower,
            @RequestParam("total") String total, @RequestParam("name-flower") String name_flower,
            HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            List<Cart> carts = new ArrayList<>();
            Cart cart = new Cart(0, id_flower, name_flower, Integer.parseInt(quantity_flower), 0, "", username,
                    "ordernow",
                    Integer.parseInt(total));
            carts.add(cart);
            modelMap.addAttribute("total", total);
            modelMap.addAttribute("carts", carts);
            return "/user/cartstep2";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-3", method = RequestMethod.GET)
    public String getPayment(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            return "/user/cartstep3";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-3", method = RequestMethod.POST)
    public String postPayment(ModelMap modelMap, @RequestParam("fullname") String fullname,
            @RequestParam("pnumber") String pnumber, @RequestParam("email") String email,
            @RequestParam("address") String address, @RequestParam("total") String total, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            modelMap.addAttribute("total", total);
            modelMap.addAttribute("fullname", fullname);
            modelMap.addAttribute("pnumber", pnumber);
            modelMap.addAttribute("email", email);
            modelMap.addAttribute("address", address);
            return "/user/cartstep3";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-3/ordernow", method = RequestMethod.POST)
    public String postPaymentOrdernow(ModelMap modelMap, @RequestParam("fullname") String fullname,
            @RequestParam("pnumber") String pnumber, @RequestParam("email") String email,
            @RequestParam("address") String address, @RequestParam("cart-status") String cart_status,
            @RequestParam("total") String total, @RequestParam("quantity-flower") String quantity_flower,
            @RequestParam("id-flower") String id_flower, @RequestParam("name-flower") String name_flower,
            HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            modelMap.addAttribute("total", total);
            modelMap.addAttribute("cart_status", cart_status);
            modelMap.addAttribute("quantity_flower", quantity_flower);
            modelMap.addAttribute("id_flower", id_flower);
            modelMap.addAttribute("fullname", fullname);
            modelMap.addAttribute("pnumber", pnumber);
            modelMap.addAttribute("email", email);
            modelMap.addAttribute("address", address);
            modelMap.addAttribute("name_flower", name_flower);

            return "/user/cartstep3";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-4/ordernow", method = RequestMethod.POST)
    public String postCompleteNow(ModelMap modelMap, @RequestParam("fullname") String fullname,
            @RequestParam("pnumber") String pnumber, @RequestParam("email") String email,
            @RequestParam("address") String address,
            @RequestParam("shipment") String shipment, @RequestParam("payment") String payment,
            @RequestParam("id-flower") String id_flower, @RequestParam("quantity-flower") String quantity_flower,
            @RequestParam("total") String total, @RequestParam("name-flower") String name_flower,
            HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Flower flower = flowerRepository.findFlowerByIdFlower(Integer.parseInt(id_flower));
            int priceShipment = 0;
            String shipmentString = "";
            if (shipment.equals("normal")) {
                priceShipment = 30000;
                shipmentString = "Thường";
            } else {
                priceShipment = 60000;
                shipmentString = "Hoả tốc";
            }
            int totalOrder = Integer.parseInt(total) + priceShipment;
            String id_random = hashPassword.RandomId(10);
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDateTime now = LocalDateTime.now();
            OrderF order = new OrderF(0, id_random, fullname, email,
                    pnumber, address, username, Integer.parseInt(id_flower), name_flower,
                    Integer.parseInt(quantity_flower), Integer.parseInt(total), "Chờ xác nhận", shipmentString, "COD",
                    priceShipment,
                    totalOrder, dtf.format(now).toString(), "");
            orderRepository.save(order);
            flowerRepository.updateQuantityFlower(flower.getQuantity() - Integer.parseInt(quantity_flower),
                    Integer.parseInt(id_flower));
            modelMap.addAttribute("message", "Đặt hàng thành công!");
            return "/user/index";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/cart-step-4", method = RequestMethod.POST)
    public String postComplete(ModelMap modelMap, @RequestParam("fullname") String fullname,
            @RequestParam("pnumber") String pnumber, @RequestParam("email") String email,
            @RequestParam("address") String address,
            @RequestParam("shipment") String shipment, @RequestParam("payment") String payment,
            @RequestParam("total") String total, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            int priceShipment = 0;
            String shipmentString = "";

            if (shipment.equals("normal")) {
                priceShipment = 30000;
                shipmentString = "Thường";
            } else {
                priceShipment = 60000;
                shipmentString = "Hoả tốc";
            }
            int totalOrder = Integer.parseInt(total) + priceShipment;
            Iterable<Cart> carts = cartRepository.findCartByUsernameOrder(username);
            Iterable<OrderF> list_orders = orderRepository.findAll();
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDateTime now = LocalDateTime.now();
            String id_random = hashPassword.RandomId(10);
            List<OrderF> orders = new ArrayList<>();

            int id = 0;
            for (OrderF orderF : list_orders) {
                id = orderF.getId();
            }
            for (Cart cart : carts) {
                id++;
                OrderF order = new OrderF(id, id_random, fullname, email,
                        pnumber, address, username, cart.getIdFlower(), cart.getNameFlower(),
                        cart.getQuantityFlower(), cart.getQuantityFlower() * cart.getPriceFlower(), "Chờ xác nhận",
                        shipmentString, "COD", priceShipment,
                        totalOrder, dtf.format(now).toString(), "");
                orders.add(order);
                orderRepository.save(order);
                cartRepository.updateWaitingCart(cart.getId());
                Flower flower = flowerRepository.findFlowerByIdFlower(cart.getIdFlower());
                flowerRepository.updateQuantityFlower(flower.getQuantity() - cart.getQuantityFlower(),
                        cart.getIdFlower());
            }
            modelMap.addAttribute("message", "Đặt hàng thành công!");
            return "/user/index";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String getProfile(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            Account account = accountRepository.findAccountByUsername(username);
            modelMap.addAttribute("account", account);
            return "/user/profile";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String getLogout(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            httpSession.removeAttribute("username");
            httpSession.removeAttribute("role");
            return "/user/login";
        }
        return "/user/index";
    }

    @PostMapping("/forgot")
    public ResponseEntity<String> postForgot(@RequestBody String email, HttpSession httpSession)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        if (httpSession.getAttribute("username") == null) {
            Account account = accountRepository.findAccountByEmail(email);
            if (account != null) {
                String newPassword = hashPassword.RandomId(10);
                String passwordHashed = hashPassword.GenerateStringPasswordHash(newPassword);
                accountRepository.updatePasswordAccount(passwordHashed, account.getUsername());
                sendEmailService.sendEmail(email, "Đặt lại mật khẩu", "Mật khẩu mới của bạn là: " + newPassword);
                System.out.println("Sent email success");
                return new ResponseEntity<>("Sent email success", HttpStatus.OK);
            }
            else{
                return new ResponseEntity<>("Sent email error", HttpStatus.OK);
            }
        }
        return null;
    }

    @RequestMapping(value = "/changepassword", method = RequestMethod.POST)
    public String changeForgot(ModelMap modelMap, @RequestParam("password") String password,
            @RequestParam("confirm-password") String confirm_password, HttpSession httpSession)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        String error = "";
        String username = "";
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            username = (String) httpSession.getAttribute("username");
            if (!password.isEmpty() && !confirm_password.isEmpty() && password.equals(confirm_password)) {
                String passwordHashed = hashPassword.GenerateStringPasswordHash(password);
                accountRepository.updatePasswordAccount(passwordHashed, username);
                modelMap.addAttribute("message", "Đổi mật khẩu thành công!");
            } else if (password.isEmpty() || confirm_password.isEmpty()) {
                error = "Vui lòng nhập đầy đủ thông tin!";
            } else if (password.length() < 6) {
                error = "Mật khẩu ít nhất 6 kí tự";
            } else if (!password.equals(confirm_password)) {
                error = "Mật khẩu không trùng khớp!";
            }
        } else {
            return "/user/login";
        }

        if (!error.isEmpty()) {
            modelMap.addAttribute("error", error);
        }
        Account account = accountRepository.findAccountByUsername(username);
        modelMap.addAttribute("account", account);
        return "/user/profile";
    }

    @RequestMapping(value = "/editaccount", method = RequestMethod.POST)
    public String editAccount(ModelMap modelMap, @RequestParam("fullname") String fullname,
            @RequestParam("email") String email,
            HttpSession httpSession) {
        String error = "";
        String username = "";
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            username = (String) httpSession.getAttribute("username");
            if (!fullname.isEmpty() && !email.isEmpty()) {
                if (email.contains("@")) {
                    Account findByEmail = accountRepository.findAccountByEmail(email);
                    if (findByEmail != null && !findByEmail.getUsername().equals(username)) {
                        error = "Email đã tồn tại!";
                    } else {
                        accountRepository.updateAccount(fullname, email, username);
                        modelMap.addAttribute("message", "Thay đổi thông tin thành công!");
                    }
                } else {
                    error = "Email không đúng định dạng!";
                }
            } else {
                error = "Vui lòng nhập đầy đủ thông tin!";
            }
            if (!error.isEmpty()) {
                modelMap.addAttribute("error", error);
            }
            Account account = accountRepository.findAccountByUsername(username);
            modelMap.addAttribute("account", account);
            return "/user/profile";
        }
        return "/user/login";
    }

    @RequestMapping(value = "/deleteaccount", method = RequestMethod.POST)
    public String deleteAccount(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("user")) {
            String username = (String) httpSession.getAttribute("username");
            httpSession.removeAttribute("username");
            httpSession.removeAttribute("role");
            accountRepository.deleteByUsername(username);
        }
        return "/user/login";
    }

    @GetMapping("/about")
    public String getInfomationPage() {
        return "/user/about";
    }
}
