import prompt from '@ohos.promptAction';

@Entry
@Component
struct ForumPostPage {
  @State voteState: number = 1;
  @State commentText: string = '';

  private post: Post = new Post(
    new Author('user/compose_master', AppTokens.Colors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppTokens.Colors.secondary), '7h ago',
      'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppTokens.Colors.primary), '5h ago',
      'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18)
  ];

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote;
            }
          })

          Text('TOP COMMENTS')
            .fontSize(AppTokens.Typography.small)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.outline)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          }, (reply: Reply) => reply.id.toString())
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

class Author {
  name: string;
  avatarColor: ResourceColor;

  constructor(name: string, avatarColor: ResourceColor) {
    this.name = name;
    this.avatarColor = avatarColor;
  }
}

class Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id;
    this.author = author;
    this.timestamp = timestamp;
    this.text = text;
    this.votes = votes;
  }
}

class Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author;
    this.timestamp = timestamp;
    this.title = title;
    this.body = body;
    this.votes = votes;
    this.commentCount = commentCount;
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#00E5FF';
    export const secondary: ResourceColor = '#FF00AA';
    export const tertiary: ResourceColor = '#76FF03';
    export const background: ResourceColor = '#101024';
    export const surface: ResourceColor = '#1C1C3A';
    export const surfaceVariant: ResourceColor = '#282850';
    export const outline: ResourceColor = '#44446A';
    export const warning: ResourceColor = '#FFD600';
    export const onPrimary: ResourceColor = '#000000';
    export const onSurface: ResourceColor = '#E0E0FF';
  }

  export namespace Typography {
    export const title: number = 20;
    export const headline: number = 22;
    export const body: number = 18;
    export const label: number = 16;
    export const small: number = 14;
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 12;
    export const large: number = 20;
  }

  export namespace Spacing {
    export const xs: number = 6;
    export const sm: number = 10;
    export const md: number = 16;
    export const lg: number = 20;
    export const xl: number = 28;
  }
}

@Component
struct UpVoteArrow {
  color: ResourceColor = AppTokens.Colors.outline;

  build() {
    Canvas(this.drawDiamond.bind(this))
      .width(28)
      .height(28)
  }

  private drawDiamond(ctx: CanvasRenderingContext2D): void {
    const w = 28;
    const h = 28;
    ctx.beginPath();
    ctx.moveTo(w / 2, 0);
    ctx.lineTo(w, h / 2);
    ctx.lineTo(w / 2, h);
    ctx.lineTo(0, h / 2);
    ctx.closePath();
    ctx.fillStyle = this.color as string;
    ctx.fill();
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', AppTokens.Colors.onSurface);
  timestamp: string = '';

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(this.author.avatarColor)
          .width(28)
          .height(28)

        Circle()
          .fill('rgba(0, 0, 0, 0.2)')
          .width(10)
          .height(10)
      }
      .width(28)
      .height(28)

      Text(this.author.name)
        .fontSize(AppTokens.Typography.small)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.small)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.small)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
struct PostCard {
  post: Post = new Post(new Author('', AppTokens.Colors.onSurface), '', '', '', 0, 0);
  @Link voteState: number;
  onVote: (newVote: number) => void = () => {};

  build() {
    Row() {
      Column() {
        Button() {
          UpVoteArrow({
            color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline
          })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(28)
        .height(28)
        .padding(0)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1);
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(AppTokens.Typography.title)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button() {
          UpVoteArrow({
            color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline
          })
          .rotate({ angle: 180 })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(28)
        .height(28)
        .padding(0)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1);
        })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headline)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(this.post.body)
          .fontSize(AppTokens.Typography.body)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)
          .width('100%')
          .textAlign(TextAlign.Start)

        Row() {
          InfoChip({ text: this.post.commentCount + ' Comments' })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: AppTokens.Spacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author('', AppTokens.Colors.onSurface), '', '', 0);

  build() {
    Row() {
      Rect()
        .fill(this.reply.author.avatarColor)
        .opacity(0.5)
        .width(3)
        .borderRadius(1.5)

      Column() {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.body)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)
          .width('100%')
          .textAlign(TextAlign.Start)

        Row() {
          InfoChip({ text: this.reply.votes + ' votes' })
          InfoChip({ text: 'Reply' })
        }
        .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Rect()
        .fill(AppTokens.Colors.surface)
        .width('100%')
        .height(60)

      Row() {
        Button() {
          Canvas(this.drawBackIcon.bind(this))
            .width(24)
            .height(24)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(50)
        .height(50)
        .padding(0)
        .onClick(() => {
          prompt.showToast({ message: 'Back' });
        })

        Blank()

        Text('r/jetpackcompose')
          .fontSize(AppTokens.Typography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Rect()
          .fill(Color.Transparent)
          .width(50)
          .height(50)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height(60)
  }

  private drawBackIcon(ctx: CanvasRenderingContext2D): void {
    const w = 24;
    const h = 24;
    const centerY = h / 2;

    ctx.strokeStyle = AppTokens.Colors.primary as string;
    ctx.lineWidth = 3;
    ctx.lineCap = 'round';

    ctx.beginPath();
    ctx.moveTo(0, centerY);
    ctx.lineTo(w, centerY);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(0, centerY);
    ctx.lineTo(w / 2, 0);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(0, centerY);
    ctx.lineTo(w / 2, h);
    ctx.stroke();
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string;

  build() {
    Column() {
      Rect()
        .fill(AppTokens.Colors.outline)
        .opacity(0.3)
        .width('100%')
        .height(1)

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .fill(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(52)
            .borderRadius(AppTokens.Shapes.large)

          if (this.commentText.length === 0) {
            Text('Add a comment...')
              .fontSize(AppTokens.Typography.body)
              .fontColor(AppTokens.Colors.outline)
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }

          TextInput({ text: this.commentText, placeholder: '' })
            .fontSize(AppTokens.Typography.body)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .height(52)
            .onChange((value: string) => {
              this.commentText = value;
            })
        }
        .layoutWeight(1)

        Button('POST')
          .type(ButtonType.Normal)
          .fontSize(AppTokens.Typography.label)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .height(52)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onClick(() => {
            prompt.showToast({ message: 'Posted: ' + this.commentText });
          })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
  }
}
