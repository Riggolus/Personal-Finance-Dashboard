<template>
    <div class="sidebar">
        <router-link to="/transactions">Transactions</router-link>
        <router-link to="/settings">Settings</router-link>    
    </div>
</template>

<style>
.sidebar {
    background-color: #f8f9fa;
    border-right: 1px solid #e9ecef;
    height: 100%;
    padding: 20px;
    width: 100px;
}
.sidebar a {
    color: #000;
    display: block;
    margin-bottom: 10px;
    text-decoration: none;
}
.sidebar a:hover {
    color: #007bff;
}
</style>