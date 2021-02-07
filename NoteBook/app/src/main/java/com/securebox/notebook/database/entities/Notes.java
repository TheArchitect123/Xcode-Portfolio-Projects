package com.securebox.notebook.database.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.Date;
import javax.annotation.Nonnull;

@Entity
public class Notes {

    @Nonnull
    @PrimaryKey(autoGenerate = true)
    public int Id;

    @NonNull
    @ColumnInfo(name = "uniqueUserIdentifier")
    public String uniqueUserId;

    @ColumnInfo(name = "notesBody")
    @NonNull
    public String bodyContent;

    @NonNull
    public Date dateCreated;
}
