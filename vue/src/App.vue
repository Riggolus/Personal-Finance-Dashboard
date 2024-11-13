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
  <footer>
      <p><a href="https://github.com/Riggolus">github</a></p>
      <p><a href="https://66d0dcf96553570d66ac15e9--nikolas-knappen.netlify.app/">Created by Nikolas Knappen</a></p>
      <p><a href="https://www.linkedin.com/in/nikolasknappen/">LinkedIn</a></p>
  </footer>
  
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
  grid-template-columns: 100%;
  grid-template-rows: 100px auto 50px;
  grid-template-areas:
    "header"
    "main-content"
    "footer";
  background: rgb(235, 237, 247);
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

router-view {
  grid-area: main-content;
}

footer {
  grid-area: footer;
  background-color: #f8f9fa;
  border-top: 1px solid #e9ecef;
  padding: 10px;
  display: flex;
  justify-content: space-evenly;
}

</style>
