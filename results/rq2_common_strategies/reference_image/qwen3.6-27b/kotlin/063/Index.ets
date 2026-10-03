import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: common.LaunchParam): void {
    console.info('EntryAbility onCreate');
  }

  onDestroy(): void {
    console.info('EntryAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    console.info('EntryAbility onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading content. Data:' + JSON.stringify(data));
    });
    
    // Hide system bars
    let windowClass: window.Window = null;
    windowStage.getMainWindow((err, win) => {
      if (err) {
        console.error(`Failed to get the main window. Code: ${err.code}, message: ${err.message}`);
        return;
      }
      windowClass = win;
      try {
        windowClass.setWindowLayoutFullScreen(true);
        windowClass.setWindowSystemBarProperties({
          statusBarColor: '#F5F5F4',
          statusBarContentColor: '#111827'
        });
      } catch (e) {
        console.error(`Failed to set window properties. Code: ${(e as BusinessError).code}, message: ${(e as BusinessError).message}`);
      }
    });
  }

  onWindowStageDestroy(): void {
    console.info('EntryAbility onWindowStageDestroy');
  }

  onForeground(): void {
    console.info('EntryAbility onForeground');
  }

  onBackground(): void {
    console.info('EntryAbility onBackground');
  }
}