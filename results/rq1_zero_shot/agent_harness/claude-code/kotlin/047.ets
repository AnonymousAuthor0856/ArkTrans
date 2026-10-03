class Pin {
  x: number;
  y: number;
  label: string;
  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct Index {
  @State pins: Pin[] = [
    new Pin(150, 250, "Group A"),
    new Pin(350, 420, "Group B"),
    new Pin(520, 310, "Group C")
  ];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    this.drawCanvas();
  }

  drawCanvas() {
    const ctx = this.context;
    const w = 600;
    const h = 220 - 16;
    ctx.clearRect(0, 0, w, h);
    ctx.fillStyle = "#FFECB3";
    ctx.fillRect(0, 0, w, h);
    for (let i = 0; i < this.pins.length; i++) {
      const p = this.pins[i];
      ctx.beginPath();
      ctx.arc(p.x, p.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = "#FF8C00";
      ctx.fill();
    }
  }

  addGroup() {
    const x = 100 + Math.floor(Math.random() * 450);
    const y = 150 + Math.floor(Math.random() * 300);
    this.pins.push(new Pin(x, y, "New"));
    this.drawCanvas();
  }

  clearGroups() {
    this.pins = [];
    this.drawCanvas();
  }

  build() {
    Column() {
      Text("Retro Group Buy")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor("#3E2723")
        .margin({ bottom: 16 })
        .width("100%")

      // Live Deals Map Card
      Column() {
        Text("Live Deals Map")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor("#3E2723")
          .margin({ bottom: 10 })
          .width("100%")

        Stack() {
          Canvas(this.context)
            .width("100%")
            .height(220)
            .backgroundColor("#FFECB3")
            .borderRadius(10)
            .padding(8)
        }
        .width("100%")
        .height(220)
      }
      .width("100%")
      .padding(16)
      .backgroundColor("#FFFFFF")
      .borderRadius(16)
      .shadow({
        radius: 8,
        color: "rgba(0,0,0,0.15)",
        offsetY: 4
      })
      .margin({ bottom: 6 })

      // Button Row
      Row() {
        Button("Add Group")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor("#3E2723")
          .backgroundColor("#FFC107")
          .borderRadius(10)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.addGroup();
          })

        Blank()
          .width(10)

        Button("Clear")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor("#3E2723")
          .backgroundColor("#FF8C00")
          .borderRadius(10)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.clearGroups();
          })
      }
      .width("100%")
      .margin({ bottom: 16 })

      // Active Groups Card
      Column() {
        Text("Active Groups")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor("#FF8C00")
          .margin({ bottom: 6 })
          .width("100%")

        ForEach(this.pins, (item: Pin) => {
          Row() {
            Text(item.label)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor("#3E2723")
              .layoutWeight(1)

            Circle({ width: 14, height: 14 })
              .fill("#FF8C00")
          }
          .width("100%")
          .margin({ bottom: 6 })
        }, (item: Pin) => item.label + item.x + item.y)
      }
      .width("100%")
      .padding(16)
      .backgroundColor("#FFFFFF")
      .borderRadius(16)
      .shadow({
        radius: 4,
        color: "rgba(0,0,0,0.1)",
        offsetY: 2
      })
    }
    .width("100%")
    .height("100%")
    .padding(16)
    .backgroundColor("#FFF8E1")
  }
}
