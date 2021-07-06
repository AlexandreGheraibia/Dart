# Application Android avec Flutter

## Contexte :


je n'avais pas d'idée sur quoi produire. J'ai donc commencé un projet en suivant des tutos sur le net. D'abord sur le langage Dart, 
puis sur Flutter. Ensuite un ami m'a dit qu'il avait un problème sur son application d'appentissage du Coran. j'ai donc pris pour fil consucteur de créer une application qui permet d'afficher la liste des sourates. Dont chaque élément permet d'accéder à la liste
de ses versets. Je ne l'ai pas terminée car mon ami, entre temps a trouvé une autre application. Mais ce petit projet m'a permit de voir le langage Dart et le fonctionnement de Flutter.


## Avis et problèmes :

Flutter grâce à ses Apis permet de mettre en place des fonctionnalités assez rapidement. Comme une base de données, ou le téléchargement de contenus externes. Les questions que l'on peut se posent sont : 
Quelle Api choisir, Est-elle compatible avec toutes les plateformes ?

Sa construction de contenus visuels est assez simple à comprendre. Mais a pour défaut l'enchevêtrement d'objets personnalisé qui peuvent vite devenir illisibles si le contenu est complexe. On une solution qui m'est apparue et que j'ai utilisée pour la navigation. A été de passer par une function, ce qui permet de complétement séparer le contenu du conteneur, et ainsi d'améliorer la lisibilité du code.

Un autre problème est l'évolution du routage. Il n'y a qu'une seule explication dans la documentation, au moment de l'écriture de ce document. Et l'implémentation de l'exemple n'est pas terrible sur certains points. C'est assez déconcertant de mettre des locations
dans une application pour smartphone. Elles ne sont visibles que sur les navigateurs web. 

En lancant mes premiers tests sur l'émulateur fourni par Android Studio. Je ne me suis pas du tout rendu compte que mes localisations n'étaient pas correctes. Pas d'erreurs, l'application tourne correctement. Puis je suis passé sur mon navigateur préféré. Et là horreur! Oh my God! ( cri d'une femme appeuré en fond), What's happenning ? Les chemins ne s'affichent pas.

## Conclusion :

Flutter est un framework qui simplifie le processus de production d'une application. Par contre, je pense qu'une interface drag and 
drop aurait été plus appropriée pour la construction des vues. Cela permettrait une construction plus instuitive et plus rapide et réduirait la production de code. Il existe peut-être déjà un plug-in pour Android studio, j'avoue ne pas avoir vérifié.


