<template>
  <div id="dashboard">
    <div class="home">
      <h1>Home</h1>
      <p>You must be authenticated to see this</p>
    </div>

    <sidebar-component/>
  </div>
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
#dashboard {
  display: grid;
  grid-template-columns: 100px auto;
  grid-template-rows: 60px auto;
  grid-template-areas:
    "header header"
    "sidebar main-content";
  height: 100vh;
  width: 100vw;
  background: rgb(161, 178, 219);
}

.home {
  grid-area: main-content;
  padding: 20px;
}
sidebar-component {
  grid-area: sidebar;
  background-color: #f8f9fa;
  border-right: 1px solid #e9ecef;
  height: 100%;
  padding: 20px;
  width: 100px;
}

</style>
