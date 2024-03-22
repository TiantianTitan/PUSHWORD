package com.pushwords;

public class Word {

    private static Long count = Long.valueOf(0);
    private Long id;
    private String word;
    private String definition;

    public Word(final String word, final  String definition){
        id = count++;
        this.word = word;
        this.definition = definition;
    }

    public Long getId() {
        return id;
    }

    public String getWord() {
        return word;
    }

    public String getDefinition() {
        return definition;
    }

    public void setWord(String word) {
        this.word = word;
    }
}


