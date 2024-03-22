package com.pushwords;

import org.springframework.stereotype.Repository;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public class WordDao implements  DAO<Word>{

    private final Map<Long, Word> words = new HashMap<>();
    private static final String WORDS_DIR = "./src/main/resources/words/";

    public WordDao(){
        File folder = new File(WORDS_DIR);
        if(!folder.exists()){
            folder.mkdirs();
        }

        File[] files = folder.listFiles((dir,name)->name.toLowerCase().endsWith(".txt"));
        for(File file: files){
            try {
                String fileContent = Files.readString(file.toPath());
                Word word = new Word(file.getName(),fileContent);
                words.put(word.getId(),word);
            }catch (IOException e){
                e.printStackTrace();
            }
        }
    }


    @Override
    public void create(final Word word) {
        words.put(word.getId(),word);
        try {
            File file = new File(WORDS_DIR+word.getWord());
            try (FileWriter writer = new FileWriter(file)) {
                writer.write(word.getDefinition());
            }
        }catch (IOException e){
            e.printStackTrace();
        }

    }

    @Override
    public Optional<Word> retrieve(final long id) {
        return Optional.empty();
    }

    @Override
    public List<Word> retrieveAll() {
        return null;
    }

    @Override
    public void update(Word word, String[] params) {

    }

    @Override
    public void delete(Word word) {
        words.remove(word.getId());
        try {
            Files.deleteIfExists(Paths.get(WORDS_DIR + word.getWord()));
        } catch (IOException e) {
            e.printStackTrace();

        }
    }
}
