package com.securebox.notebook.database.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import javax.annotation.Nonnull;

@Entity
public class SearchHistory {
    @Nonnull
    @PrimaryKey(autoGenerate = true)
    public int Id;

    @ColumnInfo(name = "previouslySearchedResult")
    @NonNull
    public String previouslySearched;
}
