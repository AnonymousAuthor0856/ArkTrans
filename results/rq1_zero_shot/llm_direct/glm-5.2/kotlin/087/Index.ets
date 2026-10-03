// TeaBrewingApp.ets
import { Component, Style, View, Stack, Column, Row, Text, Image, Button, Divider, Canvas, CanvasRenderingContext2D, RenderingContextSettings, BorderRadius, FontWeight, Alignment, FlexDirection, JustifyContent, AlignItems } from '@ohos.arkui.component';
import { Log } from '@ohos.base';

// Define color constants
const COLOR_PRIMARY: string = '#6D4C41';
const COLOR_SECONDARY: string = '#A1887F';
const COLOR_WHITE: string = '#FFFFFF';
const COLOR_GRAY: string = '#9E9E9E';
const COLOR_LIGHT_GRAY: string = '#E0E0E0';
const COLOR_DARK_GRAY: string = '#424242';
const COLOR_BG_LIGHT: string = '#F5F5F5';
const COLOR_BG_CARD: string = '#FAFAFA';
const COLOR_BG_LEAF: string = '#EFEBE9';
const COLOR_DIVIDER: string = '#EEEEEE';
const COLOR_FAV_TINT: string = '#FFCDD2';

@Entry
@Component
struct TeaBrewingApp {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top Header
      HeaderSection()

      // Spacer
      Blank().height(32)

      // Main Card displaying the selected Tea
      TeaSelectionCard()

      // Spacer
      Blank().height(32)

      // Timer Visualization
      TimerDisplay({ time: '02:00' })

      // Spacer
      Blank().height(40)

      // Action Buttons
      ControlButtons()

      // Spacer
      Blank().layoutWeight(1)

      // Preparation Steps
      PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(COLOR_WHITE)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(COLOR_GRAY)
        Text('Tea Master')
          .fontSize(22)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor(COLOR_BG_LIGHT)
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      // Abstract Tea Icon drawn with Canvas
      Stack() {
        Canvas(this.context)
          .width(30)
          .height(30)
          .onReady(() => {
            this.context.strokeStyle = COLOR_PRIMARY;
            this.context.lineWidth = 2;
            this.context.beginPath();
            this.context.arc(15, 15, 14, 0, Math.PI * 2);
            this.context.stroke();
            
            this.context.beginPath();
            this.context.moveTo(15, 7.5);
            this.context.lineTo(15, 22.5);
            this.context.stroke();
          })
      }
      .width(60)
      .height(60)
      .backgroundColor(COLOR_BG_LEAF)
      .borderRadius(30)
      .alignContent(Alignment.Center)

      // Spacer
      Blank().width(16)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(COLOR_SECONDARY)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_heart'))
        .width(24)
        .height(24)
        .fillColor(COLOR_FAV_TINT)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(COLOR_BG_CARD)
    .borderRadius(24)
    .border({ width: 1, color: COLOR_DIVIDER })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TimerDisplay {
  private time: string = '02:00';

  build() {
    Stack() {
      // Outer Progress Ring
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          // Background Ring
          this.context.strokeStyle = COLOR_BG_LIGHT;
          this.context.lineWidth = 12;
          this.context.beginPath();
          this.context.arc(110, 110, 104, 0, Math.PI * 2);
          this.context.stroke();

          // Progress Arc
          this.context.strokeStyle = COLOR_PRIMARY;
          this.context.lineCap = 'round';
          this.context.beginPath();
          // -90 degrees start, 240 degrees sweep
          this.context.arc(110, 110, 104, -Math.PI / 2, -Math.PI / 2 + (240 * Math.PI / 180));
          this.context.stroke();
        })

      // Inner Content
      Column() {
        Text('STEEPING')
          .fontSize(12)
          .fontColor(COLOR_GRAY)
          .letterSpacing(2)
        Text(this.time)
          .fontSize(48)
          .fontColor('#000000')
          .fontWeight(FontWeight.Lighter)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      // Reset Button
      Button() {
        Image($r('sys.media.ohos_ic_public_refresh'))
          .width(24)
          .height(24)
          .fillColor(COLOR_GRAY)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(COLOR_WHITE)
      .border({ width: 1, color: COLOR_LIGHT_GRAY })

      // Spacer
      Blank().width(24)

      // Play/Pause Button
      Button() {
        Row() {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(20)
            .height(20)
            .fillColor(COLOR_WHITE)
            .margin({ right: 8 })
          Text('Start')
            .fontSize(16)
            .fontColor(COLOR_WHITE)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(COLOR_PRIMARY)

      // Spacer
      Blank().width(24)

      // Add Note Button
      Button() {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor(COLOR_GRAY)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(COLOR_WHITE)
      .border({ width: 1, color: COLOR_LIGHT_GRAY })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontColor(COLOR_LIGHT_GRAY)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  private step: string = '';
  private text: string = '';

  build() {
    Column() {
      Row() {
        // Step Number
        Stack() {
          Text(this.step)
            .fontSize(11)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)
        .backgroundColor(COLOR_BG_LIGHT)
        .borderRadius(12)
        .alignContent(Alignment.Center)

        // Spacer
        Blank().width(12)

        Text(this.text)
          .fontSize(14)
          .fontColor(COLOR_DARK_GRAY)
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_check'))
          .width(16)
          .height(16)
          .fillColor(COLOR_DIVIDER)
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color(COLOR_BG_CARD)
        .strokeWidth(1)
    }
  }
}