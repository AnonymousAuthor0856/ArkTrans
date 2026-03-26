package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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

private const val NAME = "057*ShoppingCart*en"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Dark Neon"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF00E5FF)
        val secondary = Color(0xFF00BFA5)
        val tertiary = Color(0xFF69F0AE)
        val background = Color(0xFF0A0A0A)
        val surface = Color(0xFF121212)
        val surfaceVariant = Color(0xFF1E1E1E)
        val outline = Color(0xFF2C2C2C)
        val success = Color(0xFF00C853)
        val warning = Color(0xFFFFD600)
        val error = Color(0xFFD50000)
        val onPrimary = Color(0xFF0A0A0A)
        val onSecondary = Color(0xFF0A0A0A)
        val onBackground = Color(0xFFFFFFFF)
        val onSurface = Color(0xFFFFFFFF)
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
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 20.dp
        val xxl = 28.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.15f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.18f)
        val level3 = ShadowSpec(10.dp, 12.dp, 6.dp, 0.2f)
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

data class CartItem(val id: Int, val name: String, val price: Double)

@Composable
fun RootScreen() {
    val items = remember {
        listOf(
            CartItem(1, "Neon Keyboard", 89.99),
            CartItem(2, "Wireless Mouse", 49.99),
            CartItem(3, "Gaming Headset", 109.99)
        )
    }
    val promo = remember { mutableStateOf("") }
    val total = items.sumOf { it.price }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(AppTokens.Colors.background, AppTokens.Colors.surfaceVariant)
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            Text("Your Cart", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.primary)
            items.forEach {
                Card(
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level1.elevation),
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(AppTokens.Spacing.md),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            Text(it.name, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                            Text("$${String.format("%.2f", it.price)}", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.secondary)
                        }
                        Button(
                            onClick = {},
                            colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary),
                            shape = AppTokens.Shapes.medium
                        ) {
                            Text("Remove", color = AppTokens.Colors.onPrimary, style = AppTokens.TypographyTokens.label)
                        }
                    }
                }
            }
            Spacer(Modifier.height(AppTokens.Spacing.md))
            TextField(
                value = promo.value,
                onValueChange = { promo.value = it },
                modifier = Modifier.fillMaxWidth(),
                placeholder = { Text("Promo Code", color = AppTokens.Colors.onSurface.copy(alpha = 0.5f)) },
                colors = TextFieldDefaults.colors(
                    focusedContainerColor = AppTokens.Colors.surface,
                    unfocusedContainerColor = AppTokens.Colors.surfaceVariant,
                    focusedIndicatorColor = AppTokens.Colors.primary,
                    unfocusedIndicatorColor = AppTokens.Colors.outline
                ),
                shape = AppTokens.Shapes.medium
            )
            Spacer(Modifier.height(AppTokens.Spacing.md))
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant),
                elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level1.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                ) {
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                        Text("Items:", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface)
                        Text("${items.size}", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.primary)
                    }
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                        Text("Total:", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                        Text("$${String.format("%.2f", total)}", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                    }
                }
            }
            Button(
                onClick = {},
                modifier = Modifier.fillMaxWidth().height(56.dp),
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary),
                shape = AppTokens.Shapes.large
            ) {
                Text("Checkout", color = AppTokens.Colors.onSecondary, style = AppTokens.TypographyTokens.title)
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

@Preview(showBackground = true, backgroundColor = 0xFF0A0A0A)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
