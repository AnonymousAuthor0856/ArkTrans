import { common, window } from '@kit.ArkUI';
import { Image, PixelMap, NativeFormat } from '@kit.ImageKit';

// Define the main entry component
@Entry
@Component
struct MatchaBrewingScreen {
  @State isImmersive: boolean = false;

  aboutToAppear() {
    // Set immersive mode (Edge-to-Edge)
    try {
      const ctx = getContext(this) as common.UIAbilityContext;
      const w = ctx.getWindowSync();
      w.setWindowLayoutFullScreen(true);
      w.addDisplayMode(window.DisplayMode.FULLSCREEN);
      this.isImmersive = true;
    } catch (e) {
      console.error('Failed to set immersive mode');
    }
  }

  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text("MATCHA RITUAL")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#808080') // Gray
          .margin({ top: 48 })

        Text("Ceremonial Grade")
          .fontSize(28)
          .fontWeight(FontWeight.Light)
          .fontColor('#000000') // Black
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom drawn Matcha Bowl
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        // Info Row
        Row() {
          InfoItem(label: "TEMP", value: "80°C")
          InfoItem(label: "WATER", value: "70ml")
          InfoItem(label: "BAMBOO", value: "Whisk")
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1) // Take up available space

      // Bottom Section: Instructions & Action
      Column() {
        StepCard(number: "01", text: "Sift 2g of matcha powder.")
        
        StepCard(number: "02", text: "Add hot water. Whisk in 'M' shape.")
          .margin({ top: 12 })

        Button("START TIMER", { type: ButtonType.Capsule })
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F') // Matcha Green
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .margin({ top: 32 })
          .onClick(() => {
            // No logic required
          })
          
        // Add a spacer at the bottom to mimic padding
        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
  }
}

/**
 * A custom Canvas drawing of a Matcha bowl and whisk.
 */
@Component
struct MatchaBowlCanvas {
  build() {
    Canvas() {
      let path = new Path();
      
      // Draw the Bowl (Trapezoid-like shape with rounded bottom)
      path.moveTo(160 * 0.15, 160 * 0.4); // Top Left
      path.lineTo(160 * 0.85, 160 * 0.4); // Top Right
      path.quadraticCurveTo(
        160 * 0.9, 160 * 0.9, // Control
        160 * 0.5, 160 * 0.9  // Bottom Center
      );
      path.quadraticCurveTo(
        160 * 0.1, 160 * 0.9, // Control
        160 * 0.15, 160 * 0.4 // Back to Top Left
      );
      path.close();
      
      // Draw the liquid (Matcha) inside
      let liquidPath = new Path();
      liquidPath.addOval({ 
        x: 160 * 0.2, 
        y: 160 * 0.42, 
        width: 160 * 0.6, 
        height: 160 * 0.15 
      });

      // Draw Steam (Simple lines)
      let steamPath1 = new Path();
      steamPath1.moveTo(160 * 0.4, 160 * 0.3);
      steamPath1.lineTo(160 * 0.4, 160 * 0.15);
      
      let steamPath2 = new Path();
      steamPath2.moveTo(160 * 0.5, 160 * 0.25);
      steamPath2.lineTo(160 * 0.5, 160 * 0.1);
      
      let steamPath3 = new Path();
      steamPath3.moveTo(160 * 0.6, 160 * 0.3);
      steamPath3.lineTo(160 * 0.6, 160 * 0.15);

      // Render paths
      this.renderPath(path, '#333333', 0); // Bowl
      this.renderPath(liquidPath, '#8BBD52', 0); // Liquid
      this.renderPath(steamPath1, '#D3D3D3', 4, 0.5); // Steam 1
      this.renderPath(steamPath2, '#D3D3D3', 4, 0.5); // Steam 2
      this.renderPath(steamPath3, '#D3D3D3', 4, 0.5); // Steam 3
    }
    .size({ width: 160, height: 160 })
  }

  private renderPath(path: Path, color: string, strokeWidth: number = 0, alpha: number = 1) {
    if (strokeWidth > 0) {
      this.strokePath(path, Color[color], strokeWidth, alpha);
    } else {
      this.fillPath(path, Color[color]);
    }
  }
}

@Component
struct InfoItem {
  label: string;
  value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3') // LightGray

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000') // Black
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: string;
  text: string;

  build() {
    Row() {
      Text(this.number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor('#F5F5F5')
        .margin({ right: 16 })

      Text(this.text)
        .fontSize(14)
        .fontColor('#A9A9A9') // DarkGray
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}