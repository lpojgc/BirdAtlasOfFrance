<template>
  <footer>
    <img class="ODFLogo" src="/ODF-logo-filled.svg" />
    <section class="LinksSection">
      <div class="InternalLinksContent">
        <nuxt-link v-for="(link, index) in links" :key="index" :to="link.route">
          <h4>{{ link.label }}</h4>
        </nuxt-link>
        <a href="http://eepurl.com/hi6NPj" target="_blank">
          <h4>Newsletter</h4>
        </a>
      </div>
      <div class="Split"></div>
      <div class="flex">
        <a
          v-for="(item, index) in socialNetworksItems"
          :key="index"
          :href="item.link"
          target="_blank"
          class="SocialNetworksWrapper"
        >
          <img class="SocialNetworkIcon" :src="item.icon" />
        </a>
      </div>
    </section>
    <section class="LPOSection">
      <h5 class="bottom-margin-8">Oiseaux de France, un projet porté par</h5>
      <img class="LPOLogo" src="/LPO-logo.svg" />
    </section>
  </footer>
</template>

<script>
export default {
  data: () => ({
    links: [
      { label: 'À propos', route: '/about' },
      { label: 'Contact', route: '/about/contact' },
      { label: 'Mentions légales', route: '/about/legal-notices' },
    ],
    socialNetworksItems: [
      {
        icon: '/mail-filled.svg',
        link: 'mailto:oiseauxdefrance@lpo.fr',
      },
      {
        icon: '/youtube.svg',
        link: 'https://www.youtube.com/channel/UCI13cz60YLX3DHEeOEBxdMg',
      },
      {
        icon: '/github.svg',
        link: 'https://github.com/lpoaura/BirdAtlasOfFrance',
      },
    ],
  }),
}
</script>

<style scoped>
footer {
  width: 100%;
  padding: 40px 5%;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
}

.ODFLogo {
  height: 85px;
}

.LinksSection {
  flex: 1;
  max-width: 60%;
  margin: 0 32px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.InternalLinksContent {
  width: 100%;
  display: flex;
  justify-content: space-around;
}

.Split {
  width: 100%;
  height: 1px;
  min-height: 1px;
  margin: 10px 0;
  background: rgba(57, 118, 90, 0.1);
}

.SocialNetworksWrapper {
  background: rgba(107, 131, 120, 0.1);
  min-width: 40px;
  max-width: 40px;
  min-height: 40px;
  max-height: 40px;
  margin-right: 6vw;
  border-radius: 50%;
  display: flex;
}

.SocialNetworksWrapper:last-child {
  margin-right: 0;
}

.SocialNetworkIcon {
  width: 26px;
  margin: auto;
}

.LPOSection {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.LPOLogo {
  height: 80px;
  margin-left: 10px;
}
</style>
