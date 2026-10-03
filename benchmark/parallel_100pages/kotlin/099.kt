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
        
                enableEdgeToEdge()

        setContent {
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

                        MaterialTheme(
                colorScheme = androidx.compose.material3.lightColorScheme(
                    background = Color.White,
                    surface = Color.White,
                    primary = Color(0xFF556B2F), 
                    onPrimary = Color.White
                )
            ) {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = Color.White 
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

                Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
                        MatchaBowlCanvas(modifier = Modifier.size(160.dp))

            Spacer(modifier = Modifier.height(40.dp))

                        Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                InfoItem(label = "TEMP", value = "80°C")
                InfoItem(label = "WATER", value = "70ml")
                InfoItem(label = "BAMBOO", value = "Whisk")
            }
        }

                Column(
            modifier = Modifier.fillMaxWidth(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            StepCard(number = "01", text = "Sift 2g of matcha powder.")
            Spacer(modifier = Modifier.height(12.dp))
            StepCard(number = "02", text = "Add hot water. Whisk in 'M' shape.")
            
            Spacer(modifier = Modifier.height(32.dp))

            Button(
                onClick = {  },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp),
                shape = RoundedCornerShape(28.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFF556B2F) 
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

@Composable
fun MatchaBowlCanvas(modifier: Modifier = Modifier) {
    val bowlColor = Color(0xFF333333) 
    val matchaColor = Color(0xFF8BBD52) 
    
    Canvas(modifier = modifier) {
        val w = size.width
        val h = size.height
        
                val bowlPath = Path().apply {
            moveTo(w * 0.15f, h * 0.4f) 
            lineTo(w * 0.85f, h * 0.4f) 
            quadraticBezierTo(
                w * 0.9f, h * 0.9f, 
                w * 0.5f, h * 0.9f  
            )
            quadraticBezierTo(
                w * 0.1f, h * 0.9f, 
                w * 0.15f, h * 0.4f 
            )
            close()
        }
        
        drawPath(path = bowlPath, color = bowlColor)
        
                drawOval(
            color = matchaColor,
            topLeft = Offset(w * 0.2f, h * 0.42f),
            size = Size(w * 0.6f, h * 0.15f)
        )
        
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