<template>
  <div class="home">
    <h1>Home</h1>
    <p>You must be authenticated to see this</p>
  </div>

  <sidebar-component/>

</template>

<script>
import SidebarComponent from '../components/SidebarComponent.vue';

export default {
  components: {
    SidebarComponent
  }
};
</script>

<style>
.home {
  padding: 20px;
}
sidebar-component {
  background-color: #f8f9fa;
  border-right: 1px solid #e9ecef;
  height: 100%;
  padding: 20px;
  width: 100px;
}

</style>
