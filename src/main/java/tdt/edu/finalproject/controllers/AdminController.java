package tdt.edu.finalproject.controllers;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

import tdt.edu.finalproject.models.Account;
import tdt.edu.finalproject.models.Flower;
import tdt.edu.finalproject.models.OrderF;
import tdt.edu.finalproject.repositories.AccountRepository;
import tdt.edu.finalproject.repositories.FlowerRepository;
import tdt.edu.finalproject.repositories.ImageRepository;
import tdt.edu.finalproject.repositories.OrderRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private FlowerRepository flowerRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ImageRepository imageRepository;

    private HashPassword hashPassword = new HashPassword();

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLogin(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                Iterable<OrderF> orders = orderRepository.findAllOrderGroupById();
                int flower_sold = 0;
                int order_waiting = 0;
                int total_today = 0;
                for (OrderF orderF : orders) {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                    LocalDateTime now = LocalDateTime.now();
                    if (orderF.getTimeResponse().equals(dtf.format(now).toString())
                            && orderF.getStatus().equals("Thành công")) {
                        flower_sold++;
                        total_today += orderF.getTotal();
                    }
                    if (orderF.getStatus().equals("Chờ xác nhận")) {
                        order_waiting++;
                    }
                }
                modelMap.addAttribute("flower_sold", flower_sold);
                modelMap.addAttribute("order_waiting", order_waiting);
                modelMap.addAttribute("total_today", total_today);
                modelMap.addAttribute("content", "dashboard.jsp");
                modelMap.addAttribute("active", 0);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String postLogin(ModelMap modelMap, @RequestParam("admin-username") String username,
            @RequestParam("admin-password") String password, HttpSession httpSession)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        if (httpSession.getAttribute("username") == null) {
            String error = "";

            if (username.isEmpty()) {
                error = "Vui lòng điền username";
            } else if (password.isEmpty()) {
                error = "Vui lòng điền mật khẩu";
            }

            if (!error.isEmpty()) {
                modelMap.addAttribute("error", error);
                return "/admin/login";
            }

            Account account = accountRepository.findAccountByUsername(username);
            if (account != null) {
                if (hashPassword.ValidatePassword(password, account.getPassword())
                        && account.getRole().equals("admin")) {
                    httpSession.setAttribute("username", account.getUsername());
                    httpSession.setAttribute("role", account.getRole());
                    httpSession.setAttribute("fullname", account.getFullname());
                    Iterable<OrderF> orders = orderRepository.findAllOrderGroupById();
                    int flower_sold = 0;
                    int order_waiting = 0;
                    int total_today = 0;
                    for (OrderF orderF : orders) {
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                        LocalDateTime now = LocalDateTime.now();
                        if (orderF.getTimeResponse().equals(dtf.format(now).toString())
                                && orderF.getStatus().equals("Thành công")) {
                            flower_sold++;
                            total_today += orderF.getTotal();
                        }
                        if (orderF.getStatus().equals("Chờ xác nhận")) {
                            order_waiting++;
                        }
                    }
                    modelMap.addAttribute("flower_sold", flower_sold);
                    modelMap.addAttribute("order_waiting", order_waiting);
                    modelMap.addAttribute("total_today", total_today);
                    modelMap.addAttribute("content", "dashboard.jsp");
                    modelMap.addAttribute("active", 0);
                    return "/admin/layout";
                }
            }

            modelMap.addAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            return "/admin/login";
        }
        return "/admin/login";
    }

    @RequestMapping("")
    public String getDashboard(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                Iterable<OrderF> orders = orderRepository.findAllOrderGroupById();
                int flower_sold = 0;
                int order_waiting = 0;
                int total_today = 0;
                for (OrderF orderF : orders) {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                    LocalDateTime now = LocalDateTime.now();
                    if (orderF.getTimeResponse().equals(dtf.format(now).toString())
                            && orderF.getStatus().equals("Thành công")) {
                        flower_sold++;
                        total_today += orderF.getTotal();
                    }
                    if (orderF.getStatus().equals("Chờ xác nhận")) {
                        order_waiting++;
                    }
                }
                modelMap.addAttribute("flower_sold", flower_sold);
                modelMap.addAttribute("order_waiting", order_waiting);
                modelMap.addAttribute("total_today", total_today);
                modelMap.addAttribute("content", "dashboard.jsp");
                modelMap.addAttribute("active", 0);
                return "/admin/layout";
            }

            else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping("/usermanagement")
    public String getUserManagement(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                Iterable<Account> accounts = accountRepository.findAll();
                modelMap.addAttribute("accounts", accounts);
                modelMap.addAttribute("content", "usermanagement.jsp");
                modelMap.addAttribute("active", 1);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping(value = "/usermanagement/delete", method = RequestMethod.POST)
    public String deleteUserManagement(ModelMap modelMap, @RequestParam("username") String username,
            HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                accountRepository.deleteByUsername(username);
                Iterable<Account> accounts = accountRepository.findAll();
                modelMap.addAttribute("accounts", accounts);
                modelMap.addAttribute("content", "usermanagement.jsp");
                modelMap.addAttribute("active", 1);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping(value = "/usermanagement/reset", method = RequestMethod.POST)
    public String resetUserManagement(ModelMap modelMap, @RequestParam("username") String username,
            HttpSession httpSession)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                String password = hashPassword.GenerateStringPasswordHash(username);
                accountRepository.updatePasswordAccount(password, username);
                Iterable<Account> accounts = accountRepository.findAll();
                modelMap.addAttribute("accounts", accounts);
                modelMap.addAttribute("content", "usermanagement.jsp");
                modelMap.addAttribute("active", 1);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping("/productmanagement")
    public String getProductManagement(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                Iterable<Flower> flowers = flowerRepository.findAll();
                modelMap.addAttribute("flowers", flowers);
                modelMap.addAttribute("content", "productmanagement.jsp");
                modelMap.addAttribute("active", 2);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping(value = "/productmanagement/add", method = RequestMethod.POST)
    public String addProduct(ModelMap modelMap, @RequestParam("name-product") String name_product,
            @RequestParam("price-product") int price_product, @RequestParam("desc-product") String desc_product,
            @RequestParam("quantity-product") int quantity_product,
            @RequestParam("category-product") String category_product,
            @RequestParam("images-product") MultipartFile[] multipartFile, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<String> imageStrings = new ArrayList<String>();
                try {
                    for (MultipartFile multipartF : multipartFile) {
                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH-mm-ss ");
                        Date date = new Date();
                        String nameImage = formatter.format(date) + multipartF.getOriginalFilename();
                        imageStrings.add(nameImage);
                        imageRepository.saveImage(multipartF, nameImage);
                    }
                    Flower flower = new Flower(0, name_product, price_product, desc_product,
                            quantity_product, category_product,
                            (imageStrings.size()) > 0 ? (imageStrings.get(0)) : null,
                            (imageStrings.size()) > 1 ? (imageStrings.get(1)) : null,
                            (imageStrings.size()) > 2 ? (imageStrings.get(2)) : null,
                            (imageStrings.size()) > 3 ? (imageStrings.get(3)) : null,
                            (imageStrings.size()) > 4 ? (imageStrings.get(4)) : null);
                    flowerRepository.save(flower);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                Iterable<Flower> flowers = flowerRepository.findAll();
                modelMap.addAttribute("flowers", flowers);
                modelMap.addAttribute("message", "Thêm sản phẩm thành công!");
                modelMap.addAttribute("content", "productmanagement.jsp");
                modelMap.addAttribute("active", 2);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping(value = "/productmanagement/edit", method = RequestMethod.POST)
    public String updateProduct(ModelMap modelMap, @RequestParam("id-product") int id_product,
            @RequestParam("name-product") String name_product,
            @RequestParam("price-product") int price_product, @RequestParam("desc-product") String desc_product,
            @RequestParam("quantity-product") int quantity_product,
            @RequestParam("category-product") String category_product,
            @RequestParam("images-product") MultipartFile[] multipartFile, HttpSession httpSession) throws IOException {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                if (!multipartFile[0].isEmpty()) {
                    List<String> imageStrings = new ArrayList<String>();
                    try {
                        for (MultipartFile multipartF : multipartFile) {
                            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH-mm-ss ");
                            Date date = new Date();
                            String nameImage = formatter.format(date) + multipartF.getOriginalFilename();
                            imageStrings.add(nameImage);
                            imageRepository.saveImage(multipartF, nameImage);
                        }
                        Flower flower = new Flower(id_product, name_product, price_product,
                                desc_product,
                                quantity_product, category_product,
                                (imageStrings.size()) > 0 ? (imageStrings.get(0)) : null,
                                (imageStrings.size()) > 1 ? (imageStrings.get(1)) : null,
                                (imageStrings.size()) > 2 ? (imageStrings.get(2)) : null,
                                (imageStrings.size()) > 3 ? (imageStrings.get(3)) : null,
                                (imageStrings.size()) > 4 ? (imageStrings.get(4)) : null);
                        flowerRepository.save(flower);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    flowerRepository.updateFlower(name_product, price_product, desc_product, quantity_product,
                            category_product,
                            id_product);
                }

                Iterable<Flower> flowers = flowerRepository.findAll();
                modelMap.addAttribute("flowers", flowers);
                modelMap.addAttribute("message", "Sửa sản phẩm thành công!");
                modelMap.addAttribute("content", "productmanagement.jsp");
                modelMap.addAttribute("active", 2);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping(value = "/productmanagement/delete", method = RequestMethod.POST)
    public String deleteProduct(ModelMap modelMap, @RequestParam("id-product") int id_product,
            HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                flowerRepository.deleteById(id_product);
                Iterable<Flower> flowers = flowerRepository.findAll();
                modelMap.addAttribute("flowers", flowers);
                modelMap.addAttribute("message", "Xoá sản phẩm thành công!");
                modelMap.addAttribute("content", "productmanagement.jsp");
                modelMap.addAttribute("active", 2);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @RequestMapping("/ordermanagement")
    public String getOrderManagement(ModelMap modelMap, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                Iterable<OrderF> ordersGroupBy = orderRepository.findAllOrderGroupById();
                modelMap.addAttribute("ordersGroupBy", ordersGroupBy);
                modelMap.addAttribute("content", "ordermanagement.jsp");
                modelMap.addAttribute("active", 3);
                return "/admin/layout";
            } else {
                return "/user/index";
            }
        }
        return "/admin/login";
    }

    @PostMapping("/ordermanagement/delivery")
    public ResponseEntity<String> updateDeliveryOrderManagement(@RequestBody String idOrder, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                LocalDateTime now = LocalDateTime.now();
                orderRepository.updateTimeResponserder(dtf.format(now).toString(), idOrder);
                orderRepository.updateDeliveryOrder(idOrder);
                return new ResponseEntity<>("Update delivery", HttpStatus.OK);
            }
        }
        return null;
    }

    @PostMapping("/ordermanagement/success")
    public ResponseEntity<String> updateSuccessOrderManagement(@RequestBody String idOrder, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                LocalDateTime now = LocalDateTime.now();
                orderRepository.updateTimeResponserder(dtf.format(now).toString(), idOrder);
                orderRepository.updateSuccessOrder(idOrder);
                return new ResponseEntity<>("Update success", HttpStatus.OK);
            }
        }
        return null;
    }

    @PostMapping("/ordermanagement/deny")
    public ResponseEntity<String> updateDenyOrderManagement(@RequestBody String idOrder, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                LocalDateTime now = LocalDateTime.now();
                orderRepository.updateTimeResponserder(dtf.format(now).toString(), idOrder);
                orderRepository.updateDenyOrder(idOrder);
                return new ResponseEntity<>("Update deny", HttpStatus.OK);
            }
        }
        return null;
    }

    @GetMapping("/ordermanagement/detail/{id}")
    public ResponseEntity<List<OrderF>> getDetailOrderManagement(@PathVariable String id, HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<OrderF> orders = orderRepository.findOrderByIdOrder(id);
                return new ResponseEntity<>(orders, HttpStatus.OK);
            }
        }
        return null;
    }

    @GetMapping("/ordermanagement/getall")
    public ResponseEntity<List<OrderF>> getAllOrderManagement(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<OrderF> orders = orderRepository.findAllOrder();
                return new ResponseEntity<>(orders, HttpStatus.OK);
            }
        }
        return null;
    }

    @GetMapping("/ordermanagement/getsuccess")
    public ResponseEntity<List<OrderF>> getSuccesOrderManagement(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<OrderF> orders = orderRepository.findAllOrderBySuccess();
                return new ResponseEntity<>(orders, HttpStatus.OK);
            }
        }
        return null;
    }

    @GetMapping("/ordermanagement/getdelivery")
    public ResponseEntity<List<OrderF>> getDeliveryOrderManagement(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<OrderF> orders = orderRepository.findAllOrderByDelivery();
                return new ResponseEntity<>(orders, HttpStatus.OK);
            }
        }
        return null;
    }

    @GetMapping("/ordermanagement/getwaiting")
    public ResponseEntity<List<OrderF>> getWaitingOrderManagement(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<OrderF> orders = orderRepository.findAllOrderByWaiting();
                return new ResponseEntity<>(orders, HttpStatus.OK);
            }
        }
        return null;
    }

    @GetMapping("/ordermanagement/getdeny")
    public ResponseEntity<List<OrderF>> getDenyOrderManagement(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null) {
            if (httpSession.getAttribute("role").equals("admin")) {
                List<OrderF> orders = orderRepository.findAllOrderByDeny();
                return new ResponseEntity<>(orders, HttpStatus.OK);
            }
        }
        return null;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String getLogout(HttpSession httpSession) {
        if (httpSession.getAttribute("username") != null && httpSession.getAttribute("role").equals("admin")) {
            httpSession.removeAttribute("username");
            httpSession.removeAttribute("role");
            httpSession.removeAttribute("fullname");
        }
        return "/admin/login";
    }
}
