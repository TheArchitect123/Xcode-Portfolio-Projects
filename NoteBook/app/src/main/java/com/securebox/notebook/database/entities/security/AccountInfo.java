package com.securebox.notebook.database.entities.security;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.Date;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

@Entity
public class AccountInfo {

    @Nonnull
    @PrimaryKey(autoGenerate = true)
    public int Id;

    @NonNull
    @ColumnInfo(name = "uniqueUserIdentifier")
    public String uniqueUserId; //A Unique Identifier representing the user between the server & the client

    @Nonnull
    @ColumnInfo(name = "emailAddress")
    public String email_address;

    @Nullable
    public String first_name;
    @Nullable
    public String last_name;

    @Nonnull
    public Date dateJoined;
    @Nonnull
    public Date lastSignIntoApp;

    @Embedded(prefix = "secret")
    public UserPasswords passwordForUser;
}

