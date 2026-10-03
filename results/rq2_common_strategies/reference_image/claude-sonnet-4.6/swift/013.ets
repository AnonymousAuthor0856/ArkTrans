// RetroMusicPlayer.ets
// ArkTS (HarmonyOS / DevEco Studio) conversion of the SwiftUI Reto Flat music player.
// Entry page: register this struct in src/main/resources/base/profile/main_pages.json

import display from '@ohos.display';

@Entry
@Component
struct RetroMusicPlayer {
  // ---------- Design tokens ----------
  private cPrimary: string = '#EF476F';
  private cSecondary: string = '#FFD166';
  private cTertiary: string = '#06D6A0';
  private cBackground: string = '#FFFCF2';
  private cSurface: string = '#FFF8E1';
  private cSurfaceVariant: string = '#FCE7E7';
  private cOutline: string = '#BDBDBD';
  private cOnPrimary: string = '#FFFFFF';
  private cOnSecondary: string = '#1F1F1F';
  private cOnTertiary: string = '#1F1F1F';
  private cOnBackground: string = '#1F1F1F';
  private cOnSurface: string = '#1F1F1F';

  // ---------- State ----------
  @State scale: number = 1;
  @State knobCx: number = 140; // knob center X inside the deck, in vp
  @State knobCy: number = 140; // knob center Y inside the deck, in vp
  @State isDragging: boolean = false;

  // gesture anchor (not part of rendering)
  private startCx: number = 0;
  private startCy: number = 0;

  // deck geometry in design units (360 x 640 reference frame)
  private readonly deckDesignSize: number = 280;
  private readonly ringDesignRadius: number = 120;
  private readonly knobDesignSize: number = 24;

  aboutToAppear(): void {
    let w: number = 360;
    let h: number = 640;
    try {
      const d: display.Display = display.getDefaultDisplaySync();
      w = px2vp(d.width);
      h = px2vp(d.height);
    } catch (err) {
      w = 360;
      h = 640;
    }
    this.scale = Math.max(w / 360.0, h / 640.0);
    this.knobCx = (this.deckDesignSize / 2) * this.scale;
    this.knobCy = (this.deckDesignSize / 2) * this.scale;
  }

  @Builder
  deck() {
    Stack() {
      // ---- surface plate ----
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.cSurface)
        .borderRadius(16 * this.scale)
        .border({ width: 3 * this.scale, color: this.cOutline })

      // ---- record ring ----
      Circle({ width: 240 * this.scale, height: 240 * this.scale })
        .fill(Color.Transparent)
        .stroke(this.cSecondary)
        .strokeWidth(8 * this.scale)

      // ---- draggable knob ----
      Circle({ width: this.knobDesignSize * this.scale, height: this.knobDesignSize * this.scale })
        .fill(this.cPrimary)
        .position({
          x: this.knobCx - (this.knobDesignSize / 2) * this.scale,
          y: this.knobCy - (this.knobDesignSize / 2) * this.scale
        })
        .gesture(
          PanGesture({ fingers: 1, direction: PanDirection.All, distance: 0 })
            .onActionStart(() => {
              this.isDragging = true;
              this.startCx = this.knobCx;
              this.startCy = this.knobCy;
            })
            .onActionUpdate((event: GestureEvent) => {
              const centerX: number = (this.deckDesignSize / 2) * this.scale;
              const centerY: number = (this.deckDesignSize / 2) * this.scale;
              const radius: number = this.ringDesignRadius * this.scale;

              let nx: number = this.startCx + event.offsetX;
              let ny: number = this.startCy + event.offsetY;

              const dx: number = nx - centerX;
              const dy: number = ny - centerY;
              const distance: number = Math.sqrt(dx * dx + dy * dy);

              if (distance > radius) {
                const angle: number = Math.atan2(dy, dx);
                nx = centerX + Math.cos(angle) * radius;
                ny = centerY + Math.sin(angle) * radius;
              }
              this.knobCx = nx;
              this.knobCy = ny;
            })
            .onActionEnd(() => {
              this.isDragging = false;
            })
            .onActionCancel(() => {
              this.isDragging = false;
            })
        )
    }
    .width(this.deckDesignSize * this.scale)
    .height(this.deckDesignSize * this.scale)
  }

  build() {
    Column() {
      // ===== Top App Bar =====
      Column() {
        Text('Retro Music Player')
          .fontSize(34 * this.scale)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cOnSurface)
      }
      .width('100%')
      .height(80 * this.scale)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.cBackground)

      Blank()

      // ===== Main Content =====
      Column({ space: 32 * this.scale }) {
        this.deck()

        Text('Track: Summer Nights')
          .fontSize(22 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cOnSurface)

        Row({ space: 32 * this.scale }) {
          Button('Play')
            .type(ButtonType.Normal)
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cOnPrimary)
            .backgroundColor(this.cPrimary)
            .borderRadius(12 * this.scale)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .onClick(() => {
              // Play action
            })

          Button('Pause')
            .type(ButtonType.Normal)
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cOnSecondary)
            .backgroundColor(this.cSecondary)
            .borderRadius(12 * this.scale)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .onClick(() => {
              // Pause action
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Text(`Knob X:${Math.round(this.knobCx)} Y:${Math.round(this.knobCy)}`)
          .fontSize(16 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cTertiary)
      }
      .width('100%')
      .padding({ left: 32 * this.scale, right: 32 * this.scale })

      Blank()

      // ===== Bottom Spacer =====
      Row()
        .width('100%')
        .height(60 * this.scale)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}