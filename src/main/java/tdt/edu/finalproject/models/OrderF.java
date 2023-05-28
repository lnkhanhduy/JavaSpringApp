package tdt.edu.finalproject.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "orderflower")
public class OrderF {
    @Id
    @Column(name = "id")
    private int id;
    @Column(name = "idOrder")
    private String idOrder;
    @Column(name = "fullname")
    private String fullname;
    @Column(name = "email")
    private String email;
    @Column(name = "phonenumber")
    private String phonenumber;
    @Column(name = "address")
    private String address;
    @Column(name = "username")
    private String username;
    @Column(name = "idFlower")
    private int idFlower;
    @Column(name = "nameFlower")
    private String nameFlower;
    @Column(name = "quantityFlower")
    private int quantityFlower;
    @Column(name = "totalPriceFlower")
    private int totalPriceFlower;
    @Column(name = "status")
    private String status;
    @Column(name = "shipment")
    private String shipment;
    @Column(name = "payment")
    private String payment;
    @Column(name = "priceShipment")
    private int priceShipment;
    @Column(name = "total")
    private int total;
    @Column(name = "timeOrder")
    private String timeOrder;
    @Column(name = "timeResponse")
    private String timeResponse;

    public OrderF() {
    }

    public OrderF(int id, String idOrder, String fullname, String email, String phonenumber, String address,
            String username, int idFlower, String nameFlower, int quantityFlower, int totalPriceFlower, String status,
            String shipment, String payment, int priceShipment, int total, String timeOrder, String timeResponse) {
        this.id = id;
        this.idOrder = idOrder;
        this.fullname = fullname;
        this.email = email;
        this.phonenumber = phonenumber;
        this.address = address;
        this.username = username;
        this.idFlower = idFlower;
        this.nameFlower = nameFlower;
        this.quantityFlower = quantityFlower;
        this.totalPriceFlower = totalPriceFlower;
        this.status = status;
        this.shipment = shipment;
        this.payment = payment;
        this.priceShipment = priceShipment;
        this.total = total;
        this.timeOrder = timeOrder;
        this.timeResponse = timeResponse;
    }

    public int getId() {
        return id;
    }

    public String getIdOrder() {
        return idOrder;
    }

    public String getFullname() {
        return fullname;
    }

    public String getEmail() {
        return email;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public String getAddress() {
        return address;
    }

    public String getUsername() {
        return username;
    }

    public int getIdFlower() {
        return idFlower;
    }

    public String getNameFlower() {
        return nameFlower;
    }

    public int getQuantityFlower() {
        return quantityFlower;
    }

    public int getTotalPriceFlower() {
        return totalPriceFlower;
    }

    public String getStatus() {
        return status;
    }

    public String getShipment() {
        return shipment;
    }

    public String getPayment() {
        return payment;
    }

    public int getPriceShipment() {
        return priceShipment;
    }

    public int getTotal() {
        return total;
    }

    public String getTimeOrder() {
        return timeOrder;
    }

    public String getTimeResponse() {
        return timeResponse;
    }
}
