import promptAction from '@ohos.promptAction';

@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: IconType.CALENDAR, urgency: 'Today', isChecked: false },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: IconType.NOTIFICATIONS, urgency: 'Tomorrow', isChecked: false },
  ];

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, expanded: false },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, expanded: false },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, expanded: false },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, expanded: false },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, expanded: false },
  ];

  @State selectedNav: number = 0;

  private readonly BotanyWhite: string = '#FFFFFF';
  private readonly BotanySurface: string = '#FAFAFA';
  private readonly BotanyTextPrimary: string = '#1A1C19';
  private readonly BotanyTextSecondary: string = '#757575';
  private readonly BotanyAccent: string = '#2E5E4E';
  private readonly BotanyBorder: string = '#EEEEEE';

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        this.MainContent()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.BotanyWhite)

      // Floating Action Button
      Stack() {
        Circle({ width: 56, height: 56 })
          .fill(this.BotanyTextPrimary)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
        Text('+')
          .fontSize(32)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .margin({ right: 24, bottom: 80 })
      .onClick(() => {
        promptAction.showToast({ message: 'Add Plant', duration: 1000 });
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BotanyWhite)
  }

  @Builder
  TopBar() {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.BotanySurface)
        MenuIcon()
      }
      .width(40)
      .height(40)
      .onClick(() => {})

      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.BotanySurface)
        SearchIcon()
      }
      .width(40)
      .height(40)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
  }

  @Builder
  MainContent() {
    List() {
      ListItem() {
        Column() {
          Text('Good Morning,')
            .fontSize(18)
            .fontColor(this.BotanyTextSecondary)
            .margin({ bottom: 4 })
          Text('My Jungle')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.BotanyTextPrimary)
            .letterSpacing(-1)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }

      ListItem() {
        Column() {
          this.SectionHeader('Pending Tasks')

          List({ space: 16 }) {
            ForEach(this.tasks, (task: Task, index: number) => {
              ListItem() {
                this.TaskCard(task, index)
              }
            }, (task: Task) => task.id.toString())
          }
          .listDirection(Axis.Horizontal)
          .padding({ left: 24, right: 24 })
          .height(180)
        }
        .width('100%')
      }

      ListItem() {
        this.SectionHeader('Your Collection')
      }

      ForEach(this.plants, (plant: Plant, index: number) => {
        ListItem() {
          this.PlantListItem(plant, index)
        }
      }, (plant: Plant) => plant.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .padding({ bottom: 8 })
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.BotanyTextPrimary)
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskCard(task: Task, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(task.isChecked ? this.BotanyAccent : '#FFFFFF')
          if (task.icon === IconType.CALENDAR) {
            CalendarIcon({ color: task.isChecked ? '#FFFFFF' : this.BotanyTextPrimary })
          } else if (task.icon === IconType.NOTIFICATIONS) {
            NotificationsIcon({ color: task.isChecked ? '#FFFFFF' : this.BotanyTextPrimary })
          }
        }
        .width(40)
        .height(40)
      }
      .width('100%')

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.BotanyTextPrimary)
        Text(task.plantName)
          .fontSize(14)
          .fontColor(this.BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 2 })

        Stack({ alignContent: Alignment.Start }) {
          Text(task.isChecked ? 'DONE' : task.urgency)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.isChecked ? '#FFFFFF' : this.BotanyTextPrimary)
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })
        }
        .backgroundColor(task.isChecked ? this.BotanyAccent : '#E0E0E0')
        .borderRadius(8)
        .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(this.BotanySurface)
    .borderRadius(24)
    .border({
      width: task.isChecked ? 2 : 1,
      color: task.isChecked ? this.BotanyAccent : this.BotanyBorder
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      this.tasks[index].isChecked = !this.tasks[index].isChecked;
    })
  }

  @Builder
  PlantListItem(plant: Plant, index: number) {
    Row() {
      Stack() {
        Stack() {
          HeartIcon({ color: plant.daysUntilWater === 0 ? this.BotanyAccent : '#CCCCCC' })
        }
        .width(56)
        .height(56)
        .backgroundColor('#EEEEEE')
        .borderRadius(12)
      }
      .width(56)
      .height(56)

      Column() {
        Text(plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.BotanyTextPrimary)
        Text(plant.scientificName)
          .fontSize(12)
          .fontColor(this.BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (plant.expanded) {
          Row() {
            LocationIcon({ color: this.BotanyTextSecondary })
            Text(plant.location)
              .fontSize(11)
              .fontColor(this.BotanyTextSecondary)
              .margin({ left: 4 })
          }
          .margin({ top: 8 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Column() {
        if (plant.daysUntilWater === 0) {
          CheckIcon({ color: this.BotanyAccent })
          Text('Water')
            .fontSize(11)
            .fontColor(this.BotanyAccent)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 2 })
        } else {
          Text(`${plant.daysUntilWater} days`)
            .fontSize(11)
            .fontColor(this.BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.plants[index].expanded = !this.plants[index].expanded;
    })
  }

  @Builder
  BottomBar() {
    Row() {
      this.NavItem(IconType.HOME, 0)
      this.NavItem(IconType.CALENDAR, 1)
      Blank()
      this.NavItem(IconType.NOTIFICATIONS, 2)
      this.NavItem(IconType.SETTINGS, 3)
    }
    .width('100%')
    .height(72)
    .backgroundColor(this.BotanyWhite)
    .padding({ left: 48, right: 48 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavItem(iconType: IconType, index: number) {
    Column() {
      if (iconType === IconType.HOME) {
        HomeIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      } else if (iconType === IconType.CALENDAR) {
        CalendarIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      } else if (iconType === IconType.NOTIFICATIONS) {
        NotificationsIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      } else if (iconType === IconType.SETTINGS) {
        SettingsIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      }
    }
    .opacity(this.selectedNav === index ? 1.0 : 0.4)
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedNav = index;
    })
  }
}

interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  expanded: boolean;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  icon: IconType;
  urgency: string;
  isChecked: boolean;
}

enum IconType {
  HOME,
  CALENDAR,
  NOTIFICATIONS,
  SETTINGS,
}

@Component
struct MenuIcon {
  build() {
    Column() {
      Rect({ width: 18, height: 2 }).fill('#1A1C19').margin({ bottom: 3 })
      Rect({ width: 18, height: 2 }).fill('#1A1C19').margin({ bottom: 3 })
      Rect({ width: 18, height: 2 }).fill('#1A1C19')
    }
    .width(18)
    .height(14)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct SearchIcon {
  build() {
    Canvas()
    .width(20)
    .height(20)
    .onReady((ctx: DrawingRenderingContext) => {
      ctx.strokeStyle = '#1A1C19';
      ctx.lineWidth = 2;
      ctx.beginPath();
      ctx.arc(8, 8, 6, 0, Math.PI * 2);
      ctx.stroke();
      ctx.beginPath();
      ctx.moveTo(13, 13);
      ctx.lineTo(18, 18);
      ctx.stroke();
    })
  }
}

@Component
struct HomeIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Canvas()
    .width(24)
    .height(24)
    .onReady((ctx) => {
      ctx.fillStyle = this.color;
      ctx.strokeStyle = this.color;
      ctx.lineWidth = 2;
      ctx.beginPath();
      ctx.moveTo(12, 4);
      ctx.lineTo(2, 12);
      ctx.lineTo(5, 12);
      ctx.lineTo(5, 20);
      ctx.lineTo(10, 20);
      ctx.lineTo(10, 14);
      ctx.lineTo(14, 14);
      ctx.lineTo(14, 20);
      ctx.lineTo(19, 20);
      ctx.lineTo(19, 12);
      ctx.lineTo(22, 12);
      ctx.closePath();
      ctx.fill();
    })
  }
}

@Component
struct CalendarIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Canvas()
    .width(20)
    .height(20)
    .onReady((ctx) => {
      ctx.strokeStyle = this.color;
      ctx.fillStyle = this.color;
      ctx.lineWidth = 1.5;
      ctx.strokeRect(2.5, 3.5, 15, 13);
      ctx.beginPath();
      ctx.moveTo(2.5, 7);
      ctx.lineTo(17.5, 7);
      ctx.stroke();
      ctx.fillRect(6, 2, 1.5, 3);
      ctx.fillRect(12.5, 2, 1.5, 3);
      const dotY: number[] = [10, 13];
      const dotX: number[] = [5, 8.5, 12, 15.5];
      for (let y of dotY) {
        for (let x of dotX) {
          ctx.beginPath();
          ctx.arc(x, y, 1, 0, Math.PI * 2);
          ctx.fill();
        }
      }
    })
  }
}

@Component
struct NotificationsIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Canvas()
    .width(20)
    .height(20)
    .onReady((ctx) => {
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.moveTo(10, 3);
      ctx.bezierCurveTo(7, 3, 5, 5.5, 5, 9);
      ctx.lineTo(5, 13);
      ctx.lineTo(3, 15);
      ctx.lineTo(17, 15);
      ctx.lineTo(15, 13);
      ctx.lineTo(15, 9);
      ctx.bezierCurveTo(15, 5.5, 13, 3, 10, 3);
      ctx.closePath();
      ctx.fill();
      ctx.beginPath();
      ctx.arc(10, 17, 2, 0, Math.PI);
      ctx.closePath();
      ctx.fill();
    })
  }
}

@Component
struct SettingsIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Canvas()
    .width(24)
    .height(24)
    .onReady((ctx) => {
      ctx.strokeStyle = this.color;
      ctx.fillStyle = this.color;
      ctx.lineWidth = 2;
      const cx: number = 12, cy: number = 12;
      const outerR: number = 9;
      const innerR: number = 6;

      ctx.beginPath();
      for (let i: number = 0; i < 8; i++) {
        const angle: number = (i / 8) * Math.PI * 2 - Math.PI / 8;
        const x1: number = cx + Math.cos(angle - 0.15) * outerR;
        const y1: number = cy + Math.sin(angle - 0.15) * outerR;
        const x2: number = cx + Math.cos(angle + 0.15) * outerR;
        const y2: number = cy + Math.sin(angle + 0.15) * outerR;
        const x3: number = cx + Math.cos(angle + 0.15) * (outerR - 2);
        const y3: number = cy + Math.sin(angle + 0.15) * (outerR - 2);
        const x4: number = cx + Math.cos(angle - 0.15) * (outerR - 2);
        const y4: number = cy + Math.sin(angle - 0.15) * (outerR - 2);
        if (i === 0) {
          ctx.moveTo(x1, y1);
        }
        ctx.lineTo(x2, y2);
        ctx.lineTo(x3, y3);
      }
      ctx.closePath();
      ctx.fill();
      ctx.globalCompositeOperation = 'destination-out';
      ctx.beginPath();
      ctx.arc(cx, cy, innerR, 0, Math.PI * 2);
      ctx.fill();
      ctx.globalCompositeOperation = 'source-over';
      ctx.beginPath();
      ctx.arc(cx, cy, innerR, 0, Math.PI * 2);
      ctx.strokeStyle = this.color;
      ctx.stroke();
    })
  }
}

@Component
struct HeartIcon {
  @Prop color: string = '#CCCCCC';

  build() {
    Canvas()
    .width(24)
    .height(24)
    .onReady((ctx) => {
      ctx.fillStyle = this.color;
      ctx.beginPath();
      const x: number = 12, y: number = 14;
      ctx.moveTo(x, y + 4);
      ctx.bezierCurveTo(x - 10, y - 2, x - 6, y - 10, x, y - 4);
      ctx.bezierCurveTo(x + 6, y - 10, x + 10, y - 2, x, y + 4);
      ctx.fill();
    })
  }
}

@Component
struct CheckIcon {
  @Prop color: string = '#2E5E4E';

  build() {
    Canvas()
    .width(24)
    .height(24)
    .onReady((ctx) => {
      ctx.strokeStyle = this.color;
      ctx.lineWidth = 2.5;
      ctx.lineCap = 'round';
      ctx.lineJoin = 'round';
      ctx.beginPath();
      ctx.moveTo(5, 13);
      ctx.lineTo(10, 18);
      ctx.lineTo(19, 8);
      ctx.stroke();
    })
  }
}

@Component
struct LocationIcon {
  @Prop color: string = '#757575';

  build() {
    Canvas()
    .width(12)
    .height(12)
    .onReady((ctx) => {
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.moveTo(6, 1);
      ctx.bezierCurveTo(3, 1, 1, 3.5, 1, 6);
      ctx.bezierCurveTo(1, 8.5, 3.5, 10.5, 6, 11);
      ctx.bezierCurveTo(8.5, 10.5, 11, 8.5, 11, 6);
      ctx.bezierCurveTo(11, 3.5, 9, 1, 6, 1);
      ctx.closePath();
      ctx.fill();
      ctx.fillStyle = '#FFFFFF';
      ctx.beginPath();
      ctx.arc(6, 6, 1.5, 0, Math.PI * 2);
      ctx.fill();
    })
  }
}
