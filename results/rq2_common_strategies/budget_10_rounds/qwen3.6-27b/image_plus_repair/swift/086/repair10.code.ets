// main.ts
import { UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class MainAbility extends UIAbility {
  onCreate(want: Want | undefined, launchParam: AbilityConstant.LaunchParam | undefined) {
    console.info('MainAbility onCreate');
  }

  onDestroy() {
    console.info('MainAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    console.info('MainAbility onWindowStageCreate');

    windowStage.loadContent('pages/BeatMaker', (err, data) => {
      if (err.code) {
        console.error('Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading content. Data:' + JSON.stringify(data));
    });
  }

  onWindowStageDestroy() {
    console.info('MainAbility onWindowStageDestroy');
  }

  onForeground() {
    console.info('MainAbility onForeground');
  }

  onBackground() {
    console.info('MainAbility onBackground');
  }
}