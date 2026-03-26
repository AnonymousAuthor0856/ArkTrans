package com.example.myapplication

import android.os.Bundle
import android.view.View
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // 1. Enable Edge-to-Edge
        enableEdgeToEdge()

        setContent {
            // 2. Hide System Bars (Immersive Mode) inside Composable via SideEffect
            val view = LocalView.current
            if (!view.isInEditMode) {
                SideEffect {
                    val window = this.window
                    window.statusBarColor = Color.Transparent.toArgb()
                    window.navigationBarColor = Color.Transparent.toArgb()
                    
                    val insetsController = WindowCompat.getInsetsController(window, view)
                    insetsController.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
                    insetsController.hide(WindowInsetsCompat.Type.systemBars())
                }
            }

            // Simple Light Theme
            MaterialTheme(
                colorScheme = androidx.compose.material3.lightColorScheme(
                    background = Color.White,
                    surface = Color.White,
                    primary = Color(0xFF556B2F), // Dark Olive Green for Matcha theme
                    onPrimary = Color.White
                )
            ) {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = Color.White // STRICT: Pure White Background
                ) {
                    MatchaBrewingScreen()
                }
            }
        }
    }
}

@Composable
fun MatchaBrewingScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        // Top Section: Title
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Spacer(modifier = Modifier.height(48.dp))
            Text(
                text = "MATCHA RITUAL",
                fontSize = 14.sp,
                letterSpacing = 4.sp,
                fontWeight = FontWeight.Bold,
                color = Color.Gray
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Ceremonial Grade",
                fontSize = 28.sp,
                fontWeight = FontWeight.Light,
                color = Color.Black
            )
        }

        // Middle Section: Visual Art & Stats
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            // Custom drawn Matcha Bowl to avoid dependency on extended icons
            MatchaBowlCanvas(modifier = Modifier.size(160.dp))

            Spacer(modifier = Modifier.height(40.dp))

            // Info Row
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                InfoItem(label = "TEMP", value = "80°C")
                InfoItem(label = "WATER", value = "70ml")
                InfoItem(label = "BAMBOO", value = "Whisk")
            }
        }

        // Bottom Section: Instructions & Action
        Column(
            modifier = Modifier.fillMaxWidth(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            StepCard(number = "01", text = "Sift 2g of matcha powder.")
            Spacer(modifier = Modifier.height(12.dp))
            StepCard(number = "02", text = "Add hot water. Whisk in 'M' shape.")
            
            Spacer(modifier = Modifier.height(32.dp))

            Button(
                onClick = { /* No logic required */ },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp),
                shape = RoundedCornerShape(28.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFF556B2F) // Matcha Green
                ),
                elevation = ButtonDefaults.buttonElevation(0.dp)
            ) {
                Icon(
                    imageVector = Icons.Default.PlayArrow,
                    contentDescription = null,
                    modifier = Modifier.size(20.dp)
                )
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    text = "START TIMER",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.SemiBold
                )
            }
            Spacer(modifier = Modifier.height(24.dp))
        }
    }
}

/**
 * A custom Canvas drawing of a Matcha bowl and whisk.
 * Pure code drawing - no assets needed.
 */
@Composable
fun MatchaBowlCanvas(modifier: Modifier = Modifier) {
    val bowlColor = Color(0xFF333333) // Dark charcoal bowl
    val matchaColor = Color(0xFF8BBD52) // Bright matcha green
    
    Canvas(modifier = modifier) {
        val w = size.width
        val h = size.height
        
        // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
        val bowlPath = Path().apply {
            moveTo(w * 0.15f, h * 0.4f) // Top Left
            lineTo(w * 0.85f, h * 0.4f) // Top Right
            quadraticBezierTo(
                w * 0.9f, h * 0.9f, // Control
                w * 0.5f, h * 0.9f  // Bottom Center
            )
            quadraticBezierTo(
                w * 0.1f, h * 0.9f, // Control
                w * 0.15f, h * 0.4f // Back to Top Left
            )
            close()
        }
        
        drawPath(path = bowlPath, color = bowlColor)
        
        // 2. Draw the Liquid (Matcha) inside
        drawOval(
            color = matchaColor,
            topLeft = Offset(w * 0.2f, h * 0.42f),
            size = Size(w * 0.6f, h * 0.15f)
        )
        
        // 3. Draw Steam (Simple lines)
        val steamColor = Color.LightGray.copy(alpha = 0.5f)
        drawLine(
            color = steamColor,
            start = Offset(w * 0.4f, h * 0.3f),
            end = Offset(w * 0.4f, h * 0.15f),
            strokeWidth = 4f,
            cap = StrokeCap.Round
        )
        drawLine(
            color = steamColor,
            start = Offset(w * 0.5f, h * 0.25f),
            end = Offset(w * 0.5f, h * 0.1f),
            strokeWidth = 4f,
            cap = StrokeCap.Round
        )
        drawLine(
            color = steamColor,
            start = Offset(w * 0.6f, h * 0.3f),
            end = Offset(w * 0.6f, h * 0.15f),
            strokeWidth = 4f,
            cap = StrokeCap.Round
        )
    }
}

@Composable
fun InfoItem(label: String, value: String) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            text = label,
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold,
            color = Color.LightGray
        )
        Spacer(modifier = Modifier.height(4.dp))
        Text(
            text = value,
            fontSize = 16.sp,
            fontWeight = FontWeight.Medium,
            color = Color.Black
        )
    }
}

@Composable
fun StepCard(number: String, text: String) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .border(1.dp, Color(0xFFEEEEEE), RoundedCornerShape(12.dp))
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(32.dp)
                .background(Color(0xFFF5F5F5), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = number,
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold,
                color = Color.Black
            )
        }
        Spacer(modifier = Modifier.width(16.dp))
        Text(
            text = text,
            fontSize = 14.sp,
            color = Color.DarkGray
        )
    }
}

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun GreetingPreview() {
    MaterialTheme {
        MatchaBrewingScreen()
    }
}