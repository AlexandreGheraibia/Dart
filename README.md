# Application android avec flutter

## Contexte :


j'avais pas d'idée sur quel genre d'application à produire.

Donc j'ai commencé en suivant un tutoriel sur internet. Puis j'ai un ami qui m'a dit qu'il avait un problème sur son application d'appentissage du coran.

j'ai donc fait une application qui permet d'afficher la liste des sourates. Dont chaque élément permet d'accéder à la liste
de ses versets.

Je ne l'ai pas terminée car mon ami, entre temps, a trouvé une autre application. Mais ce petit projet m'a permit de voir le langage
dart et le fonctionnement de flutter.


## Avis et problèmes :

Flutter grâce à ses Apis permet de mettre en place des functionnalités assez rapidement. Comme une base de données, ou le téléchargement de contenus externes. Les questions qui se posent, son laquelle choisir ? Est-elle compatible avec toutes les plateformes ?

Sa construction de contenus visuels est assez simple à comprendre. Mais a pour défaut l'enchevêtrement d'objets personnalisé qui peuvent vite devenir illisibles si le contenu est complexe. On une solution qui m'est apparue et que j'ai utilisée pour la navigation. A été de passer par une function, ce qui permet de complétement séparer le contenu du conteneur, et ainsi d'améliorer la lisibilité du code.

Autre problème est l'évolution du routage. Il n'y a qu'une seule explication dans la documentation, au moment de l'écriture de ce document. Et l'implementation de l'exemple n'est pas terrible sur certain points. C'est assez déconcertant de mettre des locations
dans une application. Elles ne sont visibles que sur le navigateur, quand j'ai commencé à mettre en place la partie route. Et que je lancer mon application sur l'émulateur. Je ne me suis pas rendu compte que les localisations n'étaient pas correctes.
Pas d'erreurs, l'application tourne.


