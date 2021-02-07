package com.securebox.notebook.database.entities.security;

import androidx.room.ColumnInfo;
import androidx.room.Entity;

import javax.annotation.Nonnull;

@Entity
public class UserPasswords{
    @Nonnull
    @ColumnInfo(name = "secretUsersPassword")
    public String hashedPasswordForUser; //Passwords must be all hashed upon creation (hashing algorithm can be applied before using the DAO)
    @Nonnull
    @ColumnInfo(name = "secretUsersUsername")
    public String usernameForUser;
}