// RetroMusicPlayerApp.ets

// MARK: - Tokens
class RM_C {
  static readonly primary = '#EF476F';       // 粉色
  static readonly secondary = '#FFD166';     // 黄色
  static readonly tertiary = '#06D6A0';      // 绿色
  static readonly background = '#FFFCF2';    // 背景
  static readonly surface = '#FFF8E1';       // 表面
  static readonly surfaceVariant = '#FCE7E7';// 表面变体
  static readonly outline = '#BDBDBD';       // 轮廓
  static readonly success = '#06D6A0';       // 成功
  static readonly warning = '#FFA600';       // 警告
  static readonly error = '#D62828';         // 错误
  static readonly onPrimary = '#FFFFFF';     // 主色上的文字
  static readonly onSecondary = '#1F1F1F';   // 副色上的文字
  static readonly onTertiary = '#1F1F1F';    // 第三色上的文字
  static readonly onBackground = '#1F1F1F';  // 背景上的文字
  static readonly onSurface = '#1F1F1F';     // 表面上的文字
}

@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobPositionX: number = 140;
  @State knobPositionY: number = 140;
  @State isDragging: boolean = false;
  
  private scaleFactor: number = 1.0;
  private circleRadius: number = 120;
  private circleCenterX: number = 140;
  private circleCenterY: number = 140;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    // Initialize knob position to center
    this.knobPositionX = this.circleCenterX * this.scaleFactor;
    this.knobPositionY = this.circleCenterY * this.scaleFactor;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Layer
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(RM_C.background);

      // Content Layer
      Column() {
        // ===== Top App Bar =====
        Stack() {
          Text('Retro Music Player')
            .fontSize(34 * this.scaleFactor)
            .fontWeight(FontWeight.Bold)
            .fontColor(RM_C.onSurface)
        }
        .width('100%')
        .height(80 * this.scaleFactor)
        .backgroundColor(RM_C.background)
        .padding({ top: 20 * this.scaleFactor });

        Blank();

        // ===== Main Content =====
        Column({ space: 32 * this.scaleFactor }) {
          // ===== Circular Deck =====
          Stack() {
            // Background surface with border
            Column()
              .width(280 * this.scaleFactor)
              .height(280 * this.scaleFactor)
              .borderRadius(16 * this.scaleFactor)
              .backgroundColor(RM_C.surface)
              .border({ width: 3 * this.scaleFactor, color: RM_C.outline });

            // Outer circle (record) - 黄色圆环
            Column()
              .width(240 * this.scaleFactor)
              .height(240 * this.scaleFactor)
              .borderRadius(120 * this.scaleFactor)
              .border({ width: 8 * this.scaleFactor, color: RM_C.secondary });

            // Draggable knob - 红色圆点
            // Using Canvas to handle precise touch and positioning
            Canvas(this.context)
              .width(280 * this.scaleFactor)
              .height(280 * this.scaleFactor)
              .onReady(() => this.drawKnob())
              .onTouch((event: TouchEvent) => this.handleKnobTouch(event));
          }
          .width(280 * this.scaleFactor)
          .height(280 * this.scaleFactor);

          // ===== Track Info =====
          Text('Track: Summer Nights')
            .fontSize(22 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_C.onSurface);

          // ===== Control Buttons =====
          Row({ space: 32 * this.scaleFactor }) {
            Button('Play')
              .fontSize(22 * this.scaleFactor)
              .fontWeight(FontWeight.Medium)
              .fontColor(RM_C.onPrimary)
              .width(140 * this.scaleFactor)
              .height(56 * this.scaleFactor)
              .backgroundColor(RM_C.primary)
              .borderRadius(12 * this.scaleFactor);

            Button('Pause')
              .fontSize(22 * this.scaleFactor)
              .fontWeight(FontWeight.Medium)
              .fontColor(RM_C.onSecondary)
              .width(140 * this.scaleFactor)
              .height(56 * this.scaleFactor)
              .backgroundColor(RM_C.secondary)
              .borderRadius(12 * this.scaleFactor);
          }

          // ===== Knob Coordinates =====
          Text('Knob X:268 Y:303')
            .fontSize(16 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_C.tertiary);
        }
        .padding({ left: 32 * this.scaleFactor, right: 32 * this.scaleFactor });

        Blank();

        // ===== Bottom Spacer =====
        Column()
          .width('100%')
          .height(60 * this.scaleFactor);
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM_C.background);
  }

  // Handle knob dragging logic
  handleKnobTouch(event: TouchEvent) {
    if (event.type === TouchType.Down || event.type === TouchType.Move) {
      this.isDragging = true;
      
      // Get touch coordinates relative to the canvas
      const touchX = event.touches[0].x;
      const touchY = event.touches[0].y;
      
      const centerX = this.circleCenterX * this.scaleFactor;
      const centerY = this.circleCenterY * this.scaleFactor;
      const radius = this.circleRadius * this.scaleFactor;
      
      const dx = touchX - centerX;
      const dy = touchY - centerY;
      const distance = Math.sqrt(dx * dx + dy * dy);
      
      if (distance <= radius) {
        this.knobPositionX = touchX;
        this.knobPositionY = touchY;
      } else {
        // Constrain to circle edge
        const angle = Math.atan2(dy, dx);
        this.knobPositionX = centerX + Math.cos(angle) * radius;
        this.knobPositionY = centerY + Math.sin(angle) * radius;
      }
      
      this.drawKnob();
    } else if (event.type === TouchType.Up) {
      this.isDragging = false;
    }
  }

  // Draw the knob on the canvas
  drawKnob() {
    const ctx = this.context;
    if (!ctx) return;
    
    // Clear previous drawing
    ctx.clearRect(0, 0, 280 * this.scaleFactor, 280 * this.scaleFactor);
    
    // Draw red knob
    ctx.fillStyle = RM_C.primary;
    ctx.beginPath();
    ctx.arc(this.knobPositionX, this.knobPositionY, 12 * this.scaleFactor, 0, Math.PI * 2);
    ctx.fill();
  }
}