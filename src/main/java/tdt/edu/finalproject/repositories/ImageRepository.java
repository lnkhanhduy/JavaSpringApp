package tdt.edu.finalproject.repositories;

import java.io.IOException;
import org.springframework.data.repository.CrudRepository;
import org.springframework.web.multipart.MultipartFile;

import tdt.edu.finalproject.models.Flower;

public interface ImageRepository extends CrudRepository<Flower, Integer> {
    void saveImage(MultipartFile multipartFile, String nameImage) throws IOException;
}
