<template>
  <div id="capstone-app">
    <div id="header">
      <h1 id="title">Personal Finance Manager</h1>
      <div id="nav">
        <div>
          <sidebar-component v-if="$store.state.token != ''"/>
        </div>
        <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
        <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      </div>
    </div>
    <router-view />
  </div>
</template>

<script>
import SidebarComponent from './components/SidebarComponent.vue';

export default {
  components: {
    SidebarComponent
  }
};

</script>


<style scoped>
#capstone-app {
  display: grid;
  grid-template-columns: 100px auto;
  grid-template-rows: 60px auto;
  grid-template-areas:
    "header header"
    "main-content main-content";
  height: 100vh;
  width: 100vw;
  background: rgb(161, 178, 219);
}

#header {
  grid-area: header;
  background-color: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
  padding: 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

#title {
  margin: 0;
  font-size: 1.5rem;
  color: #000;
}


</style>
