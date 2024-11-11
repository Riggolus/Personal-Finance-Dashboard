<template>
  <div id="dashboard">
    <div class="home">
      <h1>Home</h1>
      <p>You must be authenticated to see this</p>
    </div>

   
  </div>
</template>

<script>

</script>

<style>
#dashboard {
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

.home {
  grid-area: main-content;
  padding: 20px;
}

</style>
