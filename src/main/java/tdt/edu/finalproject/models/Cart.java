package tdt.edu.finalproject.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @Column(name = "id")
    private int id;
    @Column(name = "idFlower")
    private int idFlower;
    @Column(name = "nameFlower")
    private String nameFlower;
    @Column(name = "quantityFlower")
    private int quantityFlower;
    @Column(name = "priceFlower")
    private int priceFlower;
    @Column(name = "imageFlower")
    private String imageFlower;
    @Column(name = "username")
    private String username;
    @Column(name = "status")
    private String status;
    @Column(name = "total")
    private int total;

    public Cart() {
    }

    public Cart(int id, int idFlower, String nameFlower, int quantityFlower, int priceFlower, String imageFlower,
            String username, String status, int total) {
        this.id = id;
        this.idFlower = idFlower;
        this.nameFlower = nameFlower;
        this.quantityFlower = quantityFlower;
        this.priceFlower = priceFlower;
        this.imageFlower = imageFlower;
        this.username = username;
        this.status = status;
        this.total = total;
    }

    public int getId() {
        return id;
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

    public int getPriceFlower() {
        return priceFlower;
    }

    public String getImageFlower() {
        return imageFlower;
    }

    public String getUsername() {
        return username;
    }

    public String getStatus() {
        return status;
    }

    public int getTotal() {
        return total;
    }
}