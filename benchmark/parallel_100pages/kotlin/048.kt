
package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "063*LiveShop*en"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Modern Blue"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1E3A8A)
        val secondary = Color(0xFF3B82F6)
        val tertiary = Color(0xFF60A5FA)
        val background = Color(0xFFF5F8FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE8EEFA)
        val outline = Color(0xFFCBD5E1)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF0B1220)
        val onBackground = Color(0xFF0B1220)
        val onSurface = Color(0xFF0B1220)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 36.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.15f)
        val level3 = ShadowSpec(10.dp, 12.dp, 6.dp, 0.18f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class LiveItem(val id: Int, val title: String, val viewers: Int, val price: String)

@Composable
fun RootScreen() {
    val liveList = remember {
        listOf(
            LiveItem(1, "Smartphone Flash Deal", 1234, "$699"),
            LiveItem(2, "Gaming Chair Special", 880, "$249"),
            LiveItem(3, "Headphones Clearance", 1640, "$99"),
            LiveItem(4, "Mechanical Keyboard", 512, "$129")
        )
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        floatingActionButton = {
            FloatingActionButton(
                onClick = {},
                containerColor = AppTokens.Colors.secondary,
                contentColor = AppTokens.Colors.onSecondary,
                shape = CircleShape
            ) {
                Text("+", style = AppTokens.TypographyTokens.title)
            }
        },
        bottomBar = {
            BottomAppBar(
                containerColor = AppTokens.Colors.surface,
                contentColor = AppTokens.Colors.onSurface
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text("Home", color = AppTokens.Colors.primary, style = AppTokens.TypographyTokens.body)
                    Text("Live", color = AppTokens.Colors.onSurface, style = AppTokens.TypographyTokens.body)
                    Text("Cart", color = AppTokens.Colors.onSurface, style = AppTokens.TypographyTokens.body)
                    Text("Profile", color = AppTokens.Colors.onSurface, style = AppTokens.TypographyTokens.body)
                }
            }
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.background,
                            AppTokens.Colors.surfaceVariant,
                            AppTokens.Colors.background
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            Text("Live Shop Events", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.primary)
            LazyColumn(
                modifier = Modifier.fillMaxSize(),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                contentPadding = PaddingValues(bottom = 96.dp)
            ) {
                items(liveList) { item ->
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level1.elevation)
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(AppTokens.Spacing.lg),
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                            Box(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .height(160.dp)
                                    .clip(AppTokens.Shapes.medium)
                                    .background(AppTokens.Colors.secondary)
                            )
                            Text(item.title, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                            Text("${item.viewers} viewers", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.tertiary)
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(item.price, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                                Button(
                                    onClick = {},
                                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                                    shape = AppTokens.Shapes.medium
                                ) {
                                    Text("Join Live", style = AppTokens.TypographyTokens.label)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF5F8FF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}

