package tdt.edu.finalproject.repositories;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;

import tdt.edu.finalproject.models.Flower;

public class ImageRepositoryImpl implements ImageRepository {
    @Override
    public void saveImage(MultipartFile multipartFile, String nameImage) throws IOException {
        String currentDir = System.getProperty("user.dir");
        String folder = currentDir + "/src/main/webapp/images/";
        byte[] bytes = multipartFile.getBytes();
        Path path = Paths.get(folder + nameImage);
        Files.write(path, bytes);
    }

    @Override
    public <S extends Flower> S save(S entity) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public <S extends Flower> Iterable<S> saveAll(Iterable<S> entities) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Optional<Flower> findById(Integer id) {
        // TODO Auto-generated method stub
        return Optional.empty();
    }

    @Override
    public boolean existsById(Integer id) {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public Iterable<Flower> findAll() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Iterable<Flower> findAllById(Iterable<Integer> ids) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public long count() {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public void deleteById(Integer id) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void delete(Flower entity) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void deleteAllById(Iterable<? extends Integer> ids) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void deleteAll(Iterable<? extends Flower> entities) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void deleteAll() {
        // TODO Auto-generated method stub
        
    }
}
