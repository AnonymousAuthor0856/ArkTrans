// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

class Author {
  name: string;
  avatarColor: string;
  constructor(name: string, avatarColor: string) {
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

class AppTokens {
  static readonly Colors = {
    primary: "#00E5FF",
    secondary: "#FF00AA",
    tertiary: "#76FF03",
    background: "#101024",
    surface: "#1C1C3A",
    surfaceVariant: "#282850",
    outline: "#44446A",
    warning: "#FFD600",
    onPrimary: "#000000",
    onSurface: "#E0E0FF",
  };

  static readonly Typography = {
    title: { size: 20, weight: FontWeight.Medium },
    headline: { size: 22, weight: FontWeight.Semibold },
    body: { size: 18, weight: FontWeight.Regular },
    label: { size: 16, weight: FontWeight.Medium },
    small: { size: 14, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static readonly Spacing = {
    xs: 6,
    sm: 10,
    md: 16,
    lg: 20,
    xl: 28,
  };
}

@Component
struct UpVoteArrow {
  color: string = "#44446A";

  build() {
    Text("\u25C6")
      .fontSize(20)
      .fontColor(this.color)
      .width(28)
      .height(28)
      .textAlign(TextAlign.Center)
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author("", "#000000");
  timestamp: string = "";

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack() {
        Circle({ width: 28, height: 28 }).fill(this.author.avatarColor)
        Circle({ width: 10, height: 10 }).fill("#00000033")
      }

      Text(this.author.name)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(AppTokens.Typography.small.weight)
        .fontColor(AppTokens.Colors.outline)
    }
  }
}

@Component
struct InfoChip {
  text: string = "";

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.small.size)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
struct PostCard {
  post: Post = new Post(new Author("", "#000000"), "", "", "", 0, 0);
  @Prop voteState: number = 0;
  onVote: (n: number) => void = (n: number) => {};

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Button() {
          UpVoteArrow({ color: this.voteState == 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline })
        }
        .backgroundColor("#00000000")
        .onClick(() => {
          this.onVote(this.voteState == 1 ? 0 : 1);
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState != 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button() {
          UpVoteArrow({ color: this.voteState == -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .rotate({ angle: 180 })
        }
        .backgroundColor("#00000000")
        .onClick(() => {
          this.onVote(this.voteState == -1 ? 0 : -1);
        })
      }
      .width(60)

      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.post.body)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)

        Row({ space: AppTokens.Spacing.xl }) {
          InfoChip({ text: this.post.commentCount.toString() + " Comments" })
          InfoChip({ text: "Share" })
        }
        .padding({ top: AppTokens.Spacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .padding(AppTokens.Spacing.lg)
    .width("100%")
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author("", "#000000"), "", "", 0);

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Rect()
        .width(3)
        .height(60)
        .fill(this.reply.author.avatarColor)
        .opacity(0.5)
        .radius(1.5)

      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)

        Row({ space: AppTokens.Spacing.md }) {
          InfoChip({ text: this.reply.votes.toString() + " votes" })
          InfoChip({ text: "Reply" })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .width("100%")
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Rect()
        .width("100%")
        .height(60)
        .fill(AppTokens.Colors.surface)

      Row() {
        Button() {
          Text("\u2261")
            .fontSize(24)
            .fontColor(AppTokens.Colors.primary)
        }
        .width(50)
        .height(50)
        .onClick(() => {})

        Blank()

        Text("r/jetpackcompose")
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Blank()
          .width(50)
          .height(50)
      }
      .width("100%")
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string;

  build() {
    Column({ space: 0 }) {
      Rect()
        .width("100%")
        .height(1)
        .fill(AppTokens.Colors.outline)
        .opacity(0.3)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row({ space: AppTokens.Spacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width("100%")
            .height(52)
            .fill(AppTokens.Colors.surfaceVariant)
            .radius(AppTokens.Shapes.large)

          if (this.commentText.length == 0) {
            Text("Add a comment...")
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.outline)
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }

          TextInput({ placeholder: "", text: this.commentText })
            .fontSize(AppTokens.Typography.body.size)
            .fontColor(AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .onChange((value: string) => {
              this.commentText = value;
            })
        }
        .layoutWeight(1)

        Button() {
          Text("POST")
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .height(52)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .height(52)
        .onClick(() => {})
      }
      .width("100%")
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
    }
  }
}

@Component
struct ForumPostView {
  @State voteState: number = 1;
  @State commentText: string = "";

  private post: Post = new Post(
    new Author("user/compose_master", AppTokens.Colors.tertiary),
    "8 hours ago",
    "The power of Jetpack Compose for single-file UIs",
    "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author("dev/android_fan", AppTokens.Colors.secondary), "7h ago", "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.", 25),
    new Reply(2, new Author("ux/designer_jane", AppTokens.Colors.primary), "5h ago", "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.", 18),
  ];

  build() {
    Column({ space: 0 }) {
      TopAppBar()

      Scroll() {
        Column({ space: 0 }) {
          PostCard({ post: this.post, voteState: this.voteState, onVote: (newVote: number) => {
            this.voteState = newVote;
          }})

          Text("TOP COMMENTS")
            .fontSize(AppTokens.Typography.small.size)
            .fontWeight(AppTokens.Typography.small.weight)
            .fontColor(AppTokens.Colors.outline)
            .width("100%")
            .textAlign(TextAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          }, (reply: Reply) => reply.id.toString())
        }
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      BottomCommentBar({ commentText: $this.commentText })
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    ForumPostView()
  }
}
