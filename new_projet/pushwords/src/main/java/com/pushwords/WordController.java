package com.pushwords;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Arrays;
import java.util.Optional;

@RestController
public class WordController {
    @Autowired
    private ObjectMapper mapper;
    private final WordDao wordDao;

    // public wordtraitement traitement;

    @Autowired
    public  WordController(WordDao wordDao){
        this.wordDao = wordDao;
    }

    @RequestMapping(value = "/words/{id}",method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<?> getWord(@PathVariable("id") long id){
        Optional<Word> word = wordDao.retrieve(id);
        if(word.isPresent()){
            String definition = word.get().getDefinition();
            ByteArrayResource resource = new ByteArrayResource(definition.getBytes());
            return ResponseEntity.ok()
                    .contentType(MediaType.TEXT_PLAIN)
                    .body(resource);
        }
        return new ResponseEntity<>("Word id=" + id + " not found.", HttpStatus.NOT_FOUND);
    }

    @RequestMapping(value = "/words",method = RequestMethod.POST)
    public ResponseEntity<?> addWord(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        String contentType = file.getContentType();
        if(!contentType.equals( MediaType.TEXT_PLAIN_VALUE)){
            return new ResponseEntity<>("Only TXT file format supported", HttpStatus.UNSUPPORTED_MEDIA_TYPE);
        }
        try {
            wordDao.create(new Word(file.getOriginalFilename(), Arrays.toString(file.getBytes())));
        }catch (IOException e){
            return new ResponseEntity<>("Failure to read file", HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>("Image uploaded", HttpStatus.OK);
    }

}







