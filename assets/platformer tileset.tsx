<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.12.1" name="platformer tileset" tilewidth="8" tileheight="8" tilecount="4" columns="0">
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0">
  <properties>
   <property name="collider" type="class" propertytype="Collider">
    <properties>
     <property name="h" type="int" value="6"/>
    </properties>
   </property>
   <property name="name" value="platform"/>
  </properties>
  <image source="prog/love/platformer/assets/platform.png" width="8" height="8"/>
 </tile>
 <tile id="1">
  <properties>
   <property name="collider" type="class" propertytype="Collider">
    <properties>
     <property name="h" type="int" value="6"/>
     <property name="w" type="int" value="6"/>
     <property name="x" type="int" value="1"/>
     <property name="y" type="int" value="1"/>
    </properties>
   </property>
   <property name="name" value="coin"/>
  </properties>
  <image source="prog/love/platformer/assets/coin.png" width="8" height="8"/>
 </tile>
 <tile id="4">
  <properties>
   <property name="name" value="player"/>
  </properties>
  <image source="prog/love/platformer/assets/player.png" width="8" height="8"/>
 </tile>
 <tile id="5">
  <properties>
   <property name="collider" type="class" propertytype="Collider">
    <properties>
     <property name="w" type="int" value="6"/>
     <property name="x" type="int" value="1"/>
    </properties>
   </property>
   <property name="name" value="goal"/>
  </properties>
  <image source="prog/love/platformer/assets/goal flag.png" width="6" height="7"/>
 </tile>
</tileset>
